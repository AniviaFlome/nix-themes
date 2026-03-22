{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.aerc;
  p = config.themes.palette;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";
in

{
  options.themes.aerc = themesLib.mkThemeOption { name = "aerc"; };

  config = lib.mkIf cfg.enable {

    programs.aerc = {
      extraConfig.ui = {
        styleset-name = themeName;
        border-char-vertical = "│";
        border-char-horizontal = "─";
      };

      stylesets.${themeName} = ''
        *.default=true
        *.normal=true

        default.fg=${p.text.hex}

        error.fg=${p.red.hex}
        warning.fg=${p.peach.hex}
        success.fg=${p.green.hex}

        tab.fg=${p.overlay0.hex}
        tab.bg=${p.mantle.hex}
        tab.selected.fg=${p.text.hex}
        tab.selected.bg=${p.base.hex}
        tab.selected.bold=true

        border.fg=${p.crust.hex}
        border.bold=true

        msglist_unread.bold=true
        msglist_flagged.fg=${p.yellow.hex}
        msglist_flagged.bold=true
        msglist_result.fg=${p.blue.hex}
        msglist_result.bold=true
        msglist_*.selected.bold=true
        msglist_*.selected.bg=${p.surface0.hex}

        dirlist_*.selected.bold=true
        dirlist_*.selected.bg=${p.surface0.hex}

        statusline_default.fg=${p.overlay2.hex}
        statusline_default.bg=${p.surface0.hex}
        statusline_error.bold=true
        statusline_success.bold=true

        selector_focused.bg=${p.surface0.hex}

        completion_default.selected.bg=${p.surface0.hex}

        [viewer]
        url.fg=${p.blue.hex}
        url.underline=true
        header.bold=true
        signature.dim=true
        diff_meta.bold=true
        diff_chunk.fg=${p.blue.hex}
        diff_chunk_func.fg=${p.blue.hex}
        diff_chunk_func.bold=true
        diff_add.fg=${p.green.hex}
        diff_del.fg=${p.red.hex}
        quote_*.fg=${p.overlay0.hex}
        quote_1.fg=${p.overlay2.hex}
      '';
    };
  };
}
