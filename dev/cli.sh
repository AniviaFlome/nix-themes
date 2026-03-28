#!/usr/bin/env bash
# nix-themes developer CLI.
#
# Usage:
#   ./dev/cli.sh docs [--out <path>]
#   ./dev/cli.sh search
#   ./dev/cli.sh list [--all]
#   ./dev/cli.sh convert <type/module.nix> [--force]
#   ./dev/cli.sh convert-all [--force]
#   ./dev/cli.sh audit [--theme <name>]
#   ./dev/cli.sh add-override <app> [--theme <name>]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# ─── helpers ──────────────────────────────────────────────────────────────────

usage() {
  cat <<EOF
Usage: $(basename "$0") <command> [args]

Commands:
  docs [--out <path>]               Generate OPTIONS.md from module options
  search                            Build the NuschtOS options search site locally
  list [--all]                      List upstream modules not yet converted locally
                                    (--all: show all, marking already-local ones)
  convert <type/module.nix>         Fetch and convert a catppuccin module from upstream
  convert <type> <module>           Same, accepts two args (e.g.: convert home-manager zellij)
  convert-all                       Fetch and convert all upstream modules
  audit [--theme <name>]            Check HM module pattern consistency
  add-override <app> [--theme <n>]  Add a theme override block to a local module
                                    (--theme: defaults to catppuccin)

Options:
  --force      (convert/convert-all/add-override) Overwrite existing files
  --theme <n>  (audit/add-override) Theme name (default: catppuccin)
  --all        (list) Show all modules including already-local ones

Examples:
  $(basename "$0") list
  $(basename "$0") list --all
  $(basename "$0") audit
  $(basename "$0") audit --theme catppuccin
  $(basename "$0") add-override foot
  $(basename "$0") add-override foot --theme dracula
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
      *) echo "Unknown option: $1" >&2; exit 1 ;;
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

# ─── module classification ────────────────────────────────────────────────────

# Classify a module's theme override pattern.
#
# A  = mkMerge + mkIf (theme == "...") — standard, no action needed
# B  = non-standard: uses // lib.optionalAttrs (theme ==), isCatppuccin flag,
#      or inline if theme == in attrset values — should use mkMerge
# C  = string/file based (writeText, extraConfig, interactiveShellInit, xdg.configFile)
#      with inline theme checks — correct as-is, mkMerge cannot merge strings
# D  = no theme-specific code — clean
classify_module() {
  local module="$1"

  # C: string/file-based output
  if grep -qE '(pkgs\.writeText|extraConfig|interactiveShellInit|xdg\.configFile)' "$module"; then
    if grep -qE '(theme ==|isCatppuccin)' "$module"; then
      echo "C"
    else
      echo "D"
    fi
    return
  fi

  # A: already uses the standard mkMerge + mkIf pattern
  if grep -q 'lib\.mkMerge' "$module" && grep -qE 'lib\.mkIf \(theme ==' "$module"; then
    echo "A"
    return
  fi

  # B: non-standard theme checks in attrset config
  if grep -qE 'lib\.optionalAttrs \(theme ==' "$module" || \
     grep -qE 'isCatppuccin' "$module" || \
     grep -qE '^[^#]*if theme ==' "$module"; then
    echo "B"
    return
  fi

  echo "D"
}

# ─── override block generation ────────────────────────────────────────────────

# Generate a skeleton override block for a theme with no upstream module.
generate_skeleton_block() {
  local app="$1"
  local theme_name="$2"

  cat <<EOF

    # TODO: add ${theme_name}-specific color overrides for ${app}
    (lib.mkIf (theme == "${theme_name}") {
      # programs.${app}.settings = {
      #   some-setting = p.someColor.hex;
      # };
    })
EOF
}

# ─── convert ──────────────────────────────────────────────────────────────────

MODULES_HM="${REPO_ROOT}/modules/home-manager"
MODULES_NOS="${REPO_ROOT}/modules/nixos"

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
    # ── Remove unsupported catppuccinLib utilities ────────────────────────────
    /catppuccinLib\.(importYAML|importINI|importINIRaw)/ {
      print "  # TODO: replace with inline config generation from p.* palette colors"
      print "  # (see modules/home-manager/bat.nix for an example)"
    }
    /catppuccinLib\.mkFlavorName/ {
      print "  # TODO: mkFlavorName not in themesLib – use config.themes.variant instead"
    }
    /catppuccinLib\.(getModuleRelease|mkVersionedOpts)/ {
      print "  # TODO: getModuleRelease/mkVersionedOpts not needed in themes system – remove"
    }
    /mkRenamedOptionModule/ {
      print "  # TODO: remove – this renames legacy catppuccin options that do not exist in themes"
    }
    /mkRemovedOptionModule/ {
      print "  # TODO: remove – this removes legacy catppuccin options that do not exist in themes"
    }

    # ── sources: remove the inherit line entirely ─────────────────────────────
    /inherit \(config\.catppuccin\) sources;/ { next }

    # ── Inject theme/palette bindings after cfg binding ───────────────────────
    /cfg = config\.catppuccin\./ {
      print
      match($0, /^[[:space:]]*/)
      indent = substr($0, 1, RLENGTH)
      print indent "theme = config.themes.theme;"
      next
    }

    # ── Replace importJSON palette with p = config.themes.palette ─────────────
    /palette = \(lib\.importJSON/ {
      match($0, /^[[:space:]]*/)
      indent = substr($0, 1, RLENGTH)
      print indent "p = config.themes.palette;"
      next
    }

    # ── Replace catppuccin-prefixed themeName with universal pattern ──────────
    /themeName = "catppuccin-\$\{cfg\.flavor\}"/ {
      match($0, /^[[:space:]]*/)
      indent = substr($0, 1, RLENGTH)
      print indent "themeName = \"${config.themes.theme}-${config.themes.variant}\";"
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
    -e 's/config\.catppuccin\.enable/config.themes.enable/g' \
    -e 's/\bpalette\.\(${[^}]*}\)/p.\1/g' \
    -e 's/\bpalette\.\([a-zA-Z_][a-zA-Z0-9_]*\)/p.\1/g' \
    -e 's/cfg\.flavor/config.themes.variant/g' \
    -e '/sources\.[a-zA-Z0-9_-]*/s/$/ # TODO: generate this content inline from p.* palette colors (sources not available in nix-themes)/'
}

# Wrap a flat `config = lib.mkIf ... { ... };` block into mkMerge + catppuccin override.
# Buffers the entire config body, then decides placement based on content:
#   - Body contains "catppuccin" → body goes into mkIf catppuccin block, generic = TODO
#   - Body is clean              → body goes into generic block, catppuccin skeleton empty
# Files that already use ( on the config line (already wrapped) are left unchanged.
wrap_in_mkmerge() {
  local file="$1"
  local appname
  appname="$(basename "${file%.nix}")"
  local tmp
  tmp="$(mktemp)"

  awk -v appname="$appname" '
    BEGIN { in_config = 0; depth = 0; buf_count = 0; has_ctp = 0 }

    # Detect a flat config block (ends with bare {).
    # Already-wrapped configs use ( on the config line — they will not match this.
    /^[[:space:]]*config = lib\.mkIf [^;]+\{[[:space:]]*$/ {
      config_header = $0
      sub(/\{[[:space:]]*$/, "(", config_header)
      in_config = 1
      depth = 1
      next
    }

    in_config {
      # Track brace depth. Nix string interpolations ${...} have balanced braces
      # so they cancel out and do not affect depth.
      n = split($0, chars, "")
      delta = 0
      for (i = 1; i <= n; i++) {
        if (chars[i] == "{") delta++
        else if (chars[i] == "}") delta--
      }
      depth += delta

      if (depth == 0) {
        # Reached the closing brace — emit the mkMerge structure.
        print config_header
        print "    lib.mkMerge ["
        if (has_ctp) {
          # Body is catppuccin-specific: generic block = TODO, body in mkIf block
          print "      {"
          print "        # TODO: add generic/universal theme settings for other palettes"
          print "      }"
          print ""
          print "      # catppuccin/" appname
          print "      (lib.mkIf (theme == \"catppuccin\") {"
          for (i = 1; i <= buf_count; i++) print "    " buf[i]
          print "      })"
        } else {
          # Body is clean: goes in generic block, catppuccin skeleton empty
          print "      {"
          for (i = 1; i <= buf_count; i++) print "    " buf[i]
          print "      }"
          print ""
          print "      # catppuccin/" appname " — add catppuccin-specific overrides here if needed"
          print "      (lib.mkIf (theme == \"catppuccin\") {"
          print "      })"
        }
        print "    ]"
        print "  );"
        in_config = 0
        buf_count = 0
        has_ctp = 0
        next
      }

      # Buffer the line (1-indexed); detect catppuccin content in non-comment lines
      buf[++buf_count] = $0
      if (!/^[[:space:]]*#/ && tolower($0) ~ /catppuccin/) has_ctp = 1
      next
    }

    { print }
  ' "$file" > "$tmp" && mv "$tmp" "$file" || { rm -f "$tmp"; return 1; }
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
  local show_all="${1:-}"

  echo "Fetching upstream module list from ${UPSTREAM_REPO}..."
  echo ""

  local hm_new=0 nos_new=0

  echo "Home-manager modules:"
  while IFS= read -r name; do
    is_skip "$name" && continue
    if [[ -f "${MODULES_HM}/${name}" ]]; then
      [[ -n "$show_all" ]] && echo "  home-manager/${name} (already local)"
    else
      echo "  home-manager/${name}"
      hm_new=$((hm_new + 1))
    fi
  done < <(fetch_upstream_module_list "home-manager")
  [[ "$hm_new" -eq 0 && -z "$show_all" ]] && echo "  (none — all upstream modules are already local)"

  echo ""
  echo "NixOS modules:"
  while IFS= read -r name; do
    is_skip "$name" && continue
    if [[ -f "${MODULES_NOS}/${name}" ]]; then
      [[ -n "$show_all" ]] && echo "  nixos/${name} (already local)"
    else
      echo "  nixos/${name}"
      nos_new=$((nos_new + 1))
    fi
  done < <(fetch_upstream_module_list "nixos")
  [[ "$nos_new" -eq 0 && -z "$show_all" ]] && echo "  (none — all upstream modules are already local)"
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
  wrap_in_mkmerge "$dst"

  local todo_count
  todo_count="$(grep -c "TODO" "$dst" 2>/dev/null || :)"
  todo_count="${todo_count:-0}"
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

# ─── audit ────────────────────────────────────────────────────────────────────

cmd_audit() {
  local filter_theme="${1:-}"

  echo "Auditing HM modules for pattern consistency..."
  [[ -n "$filter_theme" ]] && echo "(checking upstream for theme: ${filter_theme})"
  echo ""

  local standard=0 nonstandard=0 string_inline=0 clean=0 needs_upstream=0

  local upstream_modules=""
  if [[ "$filter_theme" == "catppuccin" ]]; then
    echo "Fetching upstream module list from ${UPSTREAM_REPO}..."
    upstream_modules="$(fetch_upstream_module_list "home-manager")"
    echo ""
  fi

  for module in "${MODULES_HM}"/*.nix; do
    local filename app
    filename="$(basename "$module")"
    is_skip "$filename" && continue
    app="${filename%.nix}"

    local category
    category="$(classify_module "$module")"

    local themes_used=""
    themes_used="$(grep -oE 'theme == "[a-zA-Z0-9_-]+"' "$module" 2>/dev/null | \
      grep -oE '"[a-zA-Z0-9_-]+"' | tr -d '"' | sort -u | tr '\n' ' ' | sed 's/ $//' || true)"

    local upstream_info=""
    if [[ -n "$upstream_modules" ]]; then
      if echo "$upstream_modules" | grep -qx "${app}.nix"; then
        upstream_info=" [upstream ✓]"
      else
        upstream_info=" [no upstream]"
      fi
    fi

    case "$category" in
      A)
        local themes_label=""
        [[ -n "$themes_used" ]] && themes_label=" (${themes_used})"
        printf "\033[32m✓\033[0m %-24s standard mkMerge+mkIf%s%s\n" "$app" "$themes_label" "$upstream_info"
        standard=$((standard + 1))
        ;;
      B)
        local themes_label=""
        [[ -n "$themes_used" ]] && themes_label=" (${themes_used})"
        printf "\033[33m!\033[0m %-24s non-standard inline pattern%s%s → /fix-module\n" \
          "$app" "$themes_label" "$upstream_info"
        nonstandard=$((nonstandard + 1))
        ;;
      C)
        local themes_label=""
        [[ -n "$themes_used" ]] && themes_label=" (${themes_used})"
        printf "\033[34mS\033[0m %-24s string/file template – inline if is correct%s%s\n" \
          "$app" "$themes_label" "$upstream_info"
        string_inline=$((string_inline + 1))
        ;;
      D)
        if [[ -n "$upstream_modules" ]] && echo "$upstream_modules" | grep -qx "${app}.nix"; then
          printf "\033[33m?\033[0m %-24s no theme overrides, upstream exists → add-override %s\n" "$app" "$app"
          needs_upstream=$((needs_upstream + 1))
          continue
        fi
        printf "\033[90m-\033[0m %-24s no theme-specific code\n" "$app"
        clean=$((clean + 1))
        ;;
    esac
  done

  echo ""
  printf "Summary: \033[32m%d\033[0m standard, \033[34m%d\033[0m string-template, \033[90m%d\033[0m clean" \
    "$standard" "$string_inline" "$clean"
  [[ "$nonstandard" -gt 0 ]] && printf ", \033[33m%d\033[0m non-standard\033[0m" "$nonstandard"
  [[ "$needs_upstream" -gt 0 ]] && printf ", \033[33m%d\033[0m need add-override\033[0m" "$needs_upstream"
  echo ""
}

# ─── add-override ─────────────────────────────────────────────────────────────

cmd_add_override() {
  local app="$1"
  local theme_name="${2:-catppuccin}"
  local module="${MODULES_HM}/${app}.nix"

  if [[ ! -f "$module" ]]; then
    echo "Error: local module not found: ${module}" >&2
    echo "Available apps: $(ls "${MODULES_HM}"/*.nix | xargs -n1 basename | sed 's/\.nix$//' | tr '\n' ' ')" >&2
    exit 1
  fi

  if grep -q "theme == \"${theme_name}\"" "$module"; then
    echo "Module ${app} already has a ${theme_name} override."
    [[ -z "${FORCE:-}" ]] && exit 0
    echo "(--force specified, continuing anyway)"
  fi

  # Non-catppuccin: generate a skeleton block
  if [[ "$theme_name" != "catppuccin" ]]; then
    echo "No upstream module available for '${theme_name}'. Generating skeleton..."
    echo ""
    generate_skeleton_block "$app" "$theme_name"
    echo ""
    echo "Add this block to: ${module}"
    return
  fi

  # catppuccin: fetch upstream and show converted reference
  echo "Fetching upstream catppuccin/nix module for ${app}..."
  local upstream_nix
  upstream_nix="$(fetch_upstream_module "home-manager/${app}.nix" 2>/dev/null)" || true

  if [[ -z "$upstream_nix" || ! -f "${upstream_nix:-}" ]]; then
    echo "Error: no upstream catppuccin/nix module found for '${app}'." >&2
    echo "" >&2
    echo "Available upstream modules:" >&2
    fetch_upstream_module_list "home-manager" | sed 's/\.nix$//' | while read -r name; do
      echo "  ${name}" >&2
    done
    exit 1
  fi

  echo ""
  echo "─── upstream catppuccin/nix (home-manager/${app}.nix) ────────────────────────"
  cat "$upstream_nix"
  echo "──────────────────────────────────────────────────────────────────────────────"
  echo ""

  local converted
  converted="$(transform_module "$upstream_nix" "$app")"

  echo "─── converted to nix-themes style ───────────────────────────────────────────"
  echo "$converted"
  echo "──────────────────────────────────────────────────────────────────────────────"
  echo ""

  local todo_count
  todo_count="$(echo "$converted" | grep -c 'TODO' || echo 0)"
  [[ "$todo_count" -gt 0 ]] && printf "\033[33m⚠\033[0m  %d TODO(s) need manual attention.\n" "$todo_count"

  echo ""
  echo "Your local module: ${module}"
  echo "Use the converted output above as reference to add the catppuccin overrides."
}

# ─── main ─────────────────────────────────────────────────────────────────────

FORCE=""
SHOW_ALL=""
THEME_ARG=""
ARGS=()
for arg in "$@"; do
  case "$arg" in
    --force) FORCE="1" ;;
    --all) SHOW_ALL="1" ;;
    *) ARGS+=("$arg") ;;
  esac
done

# Extract --theme <name> from ARGS
FILTERED_ARGS=()
i=0
while [[ $i -lt ${#ARGS[@]} ]]; do
  if [[ "${ARGS[$i]}" == "--theme" ]]; then
    i=$((i + 1))
    THEME_ARG="${ARGS[$i]:-catppuccin}"
  else
    FILTERED_ARGS+=("${ARGS[$i]}")
  fi
  i=$((i + 1))
done
ARGS=("${FILTERED_ARGS[@]}")

cmd="${ARGS[0]:-}"

case "$cmd" in
  docs)        cmd_docs "${ARGS[@]:1}" ;;
  search)      cmd_search ;;
  list)        cmd_list "$SHOW_ALL" ;;
  convert)
    [[ -z "${ARGS[1]:-}" ]] && { echo "Error: specify module path, e.g.: convert home-manager/zellij.nix" >&2; exit 1; }
    # Accept both "home-manager/zellij.nix" and "home-manager zellij" forms
    if [[ -n "${ARGS[2]:-}" ]]; then
      module_path="${ARGS[1]}/${ARGS[2]%.nix}.nix"
    else
      module_path="${ARGS[1]}"
      # Append .nix if missing
      [[ "$module_path" != *.nix ]] && module_path="${module_path}.nix"
    fi
    cmd_convert "$module_path" "$FORCE"
    ;;
  convert-all) cmd_convert_all "$FORCE" ;;
  audit)       cmd_audit "${THEME_ARG}" ;;
  add-override)
    [[ -z "${ARGS[1]:-}" ]] && { echo "Error: specify app name, e.g.: add-override foot" >&2; exit 1; }
    cmd_add_override "${ARGS[1]}" "${THEME_ARG:-catppuccin}"
    ;;
  *)
    usage
    exit 1
    ;;
esac
