#!/usr/bin/env bash
# nix-themes developer CLI.
#
# Usage:
#   ./dev/cli.sh docs [--out <path>]
#   ./dev/cli.sh search
#   ./dev/cli.sh convert <type/module.nix> [--force]
#   ./dev/cli.sh convert-all [--force]
#   ./dev/cli.sh list

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# ─── helpers ──────────────────────────────────────────────────────────────────

usage() {
  cat <<EOF
Usage: $(basename "$0") <command> [args]

Commands:
  docs [--out <path>]               Generate OPTIONS.md from module options
                                    (default: <repo-root>/OPTIONS.md)
  search                            Build the NuschtOS options search site locally
  list                              List upstream catppuccin/nix modules
  convert <type/module.nix>         Fetch and convert a catppuccin module from upstream
  convert-all                       Fetch and convert all upstream modules

Options:
  --force   (convert/convert-all) Overwrite existing output files

Examples:
  $(basename "$0") docs
  $(basename "$0") docs --out /tmp/options.md
  $(basename "$0") search
  $(basename "$0") list
  $(basename "$0") convert home-manager/zellij.nix
  $(basename "$0") convert-all --force
EOF
}

# ─── docs ─────────────────────────────────────────────────────────────────────

cmd_docs() {
  local out="${REPO_ROOT}/OPTIONS.md"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --out) out="$2"; shift 2 ;;
      *) echo "Unknown option: $1" >&2; echo "Usage: $(basename "$0") docs [--out <path>]" >&2; exit 1 ;;
    esac
  done

  echo "Building themes options documentation..."
  result=$(nix build "${SCRIPT_DIR}#themesOptionsMD" --no-link --print-out-paths --no-write-lock-file)
  cp "$result" "$out"
  echo "Written to $out"
}

# ─── search ───────────────────────────────────────────────────────────────────

cmd_search() {
  echo "Building NuschtOS options search site..."
  result=$(nix build "${SCRIPT_DIR}#search" --no-link --print-out-paths --no-write-lock-file)
  echo "Built at: $result"
  echo "Preview:  python3 -m http.server -d $result"
}

# ─── upstream fetch ───────────────────────────────────────────────────────────

UPSTREAM_REPO="catppuccin/nix"
UPSTREAM_BRANCH="main"
UPSTREAM_RAW="https://raw.githubusercontent.com/${UPSTREAM_REPO}/${UPSTREAM_BRANCH}"
UPSTREAM_API="https://api.github.com/repos/${UPSTREAM_REPO}/contents"

fetch_upstream_module() {
  local module_path="$1"  # e.g. "home-manager/zellij.nix"
  local cache_file="${REPO_ROOT}/.cache/upstream/${module_path}"

  if [[ -f "$cache_file" && -z "${FORCE:-}" ]]; then
    echo "$cache_file"
    return
  fi

  mkdir -p "$(dirname "$cache_file")"
  local url="${UPSTREAM_RAW}/modules/${module_path}"

  if ! curl -fsSL "$url" -o "$cache_file"; then
    echo "Error: failed to fetch ${url}" >&2
    return 1
  fi

  echo "$cache_file"
}

fetch_upstream_module_list() {
  local type="$1"  # "home-manager" or "nixos"
  curl -fsSL "${UPSTREAM_API}/modules/${type}" |
    grep '"name"' |
    sed 's/.*"name": "\(.*\)".*/\1/' |
    grep '\.nix$' |
    grep -vE '^(default|all-modules)\.nix$'
}

# ─── convert ──────────────────────────────────────────────────────────────────
# NOTE: Converts catppuccin-style modules from upstream catppuccin/nix into the
# themes system. Use --force to overwrite already-converted local modules.

MODULES_HM="${REPO_ROOT}/modules/home-manager"
MODULES_NOS="${REPO_ROOT}/modules/nixos"
MODULES_PKGS="${REPO_ROOT}/pkgs"

SKIP_MODULES=("default.nix" "all-modules.nix")

is_skip() {
  local name="$1"
  for skip in "${SKIP_MODULES[@]}"; do
    [[ "$name" == "$skip" ]] && return 0
  done
  return 1
}

sed_escape() {
  printf '%s' "$1" | sed 's/[[\.*^$\/]/\\&/g'
}

transform_module() {
  local src="$1"
  local appname="$2"
  local app_esc
  app_esc="$(sed_escape "$appname")"

  awk '
    /catppuccinLib\.(importYAML|importINI|importINIRaw)/ {
      print "  # TODO: no file import in themesLib – generate this config inline from config.themes.palette"
    }
    /catppuccinLib\.mkFlavorName/ {
      print "  # TODO: mkFlavorName not in themesLib – adapt for config.themes.variant instead"
    }
    /catppuccinLib\.(getModuleRelease|mkVersionedOpts)/ {
      print "  # TODO: review whether getModuleRelease/mkVersionedOpts are needed in the themes system"
    }
    /mkRenamedOptionModule/ {
      print "  # TODO: remove or adapt – this renames legacy catppuccin options that do not exist in themes"
    }
    /mkRemovedOptionModule/ {
      print "  # TODO: remove or adapt – this removes legacy catppuccin options that do not exist in themes"
    }
    /inherit \(config\.catppuccin\) sources;/ {
      print "  # TODO: sources removed – generate theme content inline from config.themes.palette"
      next
    }
    /palette = \(lib\.importJSON/ {
      match($0, /^[[:space:]]*/)
      indent = substr($0, 1, RLENGTH)
      print indent "palette = config.themes.palette;"
      next
    }
    { print }
  ' "$src" | \
  sed \
    -e 's/^{ catppuccinLib }:$/{ themesLib }:/' \
    -e 's/catppuccinLib\.mkCatppuccinOption/themesLib.mkThemeOption/g' \
    -e 's/catppuccinLib\./themesLib./g' \
    -e "s/options\.catppuccin\.${app_esc}/options.themes.${appname}/g" \
    -e "s/config\.catppuccin\.${app_esc}/config.themes.${appname}/g" \
    -e '/sources\.[a-zA-Z0-9_-]*/s/$/ # TODO: replace with inline palette-based generation/' \
    -e '/cfg\.flavor/s/$/ # TODO: flavor → variant; verify palette supports this variant/' \
    -e 's/config\.catppuccin\.enable/config.catppuccin.enable # TODO: replace with config.themes.enable/g'
}

update_all_modules() {
  local all_modules="$1"
  local filename="$2"
  local entry="./${filename}"

  if grep -qF "$entry" "$all_modules"; then
    echo "    (already listed in $(basename "$all_modules"))"
    return
  fi

  local ks_end="# keep-sorted end"
  local tmp
  tmp="$(mktemp)"
  sed "s|${ks_end}|  ${entry}\n${ks_end}|" "$all_modules" > "$tmp"
  mv "$tmp" "$all_modules"
  echo "    Added ${entry} to $(basename "$all_modules")"
}

cmd_list() {
  echo "Fetching upstream module list from ${UPSTREAM_REPO}..."
  echo ""

  echo "Home-manager modules:"
  while IFS= read -r name; do
    is_skip "$name" && continue
    local suffix=""
    [[ -f "${MODULES_HM}/${name}" ]] && suffix=" (already local)"
    echo "  home-manager/${name}${suffix}"
  done < <(fetch_upstream_module_list "home-manager")

  echo ""
  echo "NixOS modules:"
  while IFS= read -r name; do
    is_skip "$name" && continue
    local suffix=""
    [[ -f "${MODULES_NOS}/${name}" ]] && suffix=" (already local)"
    echo "  nixos/${name}${suffix}"
  done < <(fetch_upstream_module_list "nixos")
}

cmd_convert() {
  local module_path="$1"
  local force="${2:-}"

  local type="${module_path%%/*}"
  local filename="${module_path##*/}"
  local appname="${filename%.nix}"

  local dst_dir all_modules

  case "$type" in
    home-manager)
      dst_dir="${MODULES_HM}"
      all_modules="${MODULES_HM}/all-modules.nix"
      ;;
    nixos)
      dst_dir="${MODULES_NOS}"
      all_modules="${MODULES_NOS}/all-modules.nix"
      ;;
    *)
      echo "Error: unknown module type '${type}' – use 'home-manager' or 'nixos'" >&2
      return 1
      ;;
  esac

  local dst="${dst_dir}/${filename}"

  if [[ -f "$dst" && -z "$force" ]]; then
    echo "  Skipping ${module_path} (already exists; use --force to overwrite)"
    return
  fi

  local src
  src="$(fetch_upstream_module "${module_path}")" || return 1

  transform_module "$src" "$appname" > "$dst"

  local todo_count
  todo_count="$(grep -c "TODO" "$dst" 2>/dev/null || echo 0)"
  printf "  Converted: modules/%s [%d TODO(s)]\n" "$module_path" "$todo_count"
  update_all_modules "$all_modules" "$filename"
}

cmd_convert_all() {
  local force="${1:-}"
  local converted=0 skipped=0

  echo "Fetching upstream module list from ${UPSTREAM_REPO}..."

  for type in home-manager nixos; do
    local dst_dir
    [[ "$type" == "home-manager" ]] && dst_dir="${MODULES_HM}" || dst_dir="${MODULES_NOS}"

    while IFS= read -r name; do
      is_skip "$name" && continue

      if [[ -f "${dst_dir}/${name}" && -z "$force" ]]; then
        skipped=$((skipped + 1))
        echo "  Skipping ${type}/${name} (already exists; use --force)"
        continue
      fi

      cmd_convert "${type}/${name}" "$force" && converted=$((converted + 1))
    done < <(fetch_upstream_module_list "$type")
  done

  echo ""
  echo "Done: ${converted} converted, ${skipped} skipped"
}

# ─── main ─────────────────────────────────────────────────────────────────────

FORCE=""
ARGS=()
for arg in "$@"; do
  [[ "$arg" == "--force" ]] && FORCE="1" || ARGS+=("$arg")
done

cmd="${ARGS[0]:-}"

case "$cmd" in
  docs)
    cmd_docs "${ARGS[@]:1}"
    ;;
  search)
    cmd_search
    ;;
  list)
    cmd_list
    ;;
  convert)
    if [[ -z "${ARGS[1]:-}" ]]; then
      echo "Error: specify module path, e.g.: convert home-manager/zellij.nix" >&2
      exit 1
    fi
    cmd_convert "${ARGS[1]}" "$FORCE"
    ;;
  convert-all)
    cmd_convert_all "$FORCE"
    ;;
  *)
    usage
    exit 1
    ;;
esac
