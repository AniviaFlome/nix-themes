{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.yazi;
  p = config.themes.palette;
  accent = cfg.accent;
  enable = cfg.enable && config.programs.yazi.enable;
in

{
  options.themes.yazi = themesLib.mkThemeOption {
    name = "yazi";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    xdg.configFile."yazi/theme.toml".text = ''
      [app]
      overall = { bg = "${p.base.hex}" }

      [mgr]
      cwd = { fg = "${p.teal.hex}" }

      find_keyword  = { fg = "${p.yellow.hex}", italic = true }
      find_position = { fg = "${p.pink.hex}", bg = "reset", italic = true }

      marker_copied   = { fg = "${p.green.hex}", bg = "${p.green.hex}" }
      marker_cut      = { fg = "${p.red.hex}", bg = "${p.red.hex}" }
      marker_marked   = { fg = "${p.teal.hex}", bg = "${p.teal.hex}" }
      marker_selected = { fg = "${p.${accent}.hex}", bg = "${p.${accent}.hex}" }

      count_copied   = { fg = "${p.base.hex}", bg = "${p.green.hex}" }
      count_cut      = { fg = "${p.base.hex}", bg = "${p.red.hex}" }
      count_selected = { fg = "${p.base.hex}", bg = "${p.${accent}.hex}" }

      border_symbol = "│"
      border_style  = { fg = "${p.overlay1.hex}" }

      [tabs]
      active   = { fg = "${p.base.hex}", bg = "${p.text.hex}", bold = true }
      inactive = { fg = "${p.text.hex}", bg = "${p.surface1.hex}" }

      [mode]
      normal_main = { fg = "${p.base.hex}", bg = "${p.${accent}.hex}", bold = true }
      normal_alt  = { fg = "${p.${accent}.hex}", bg = "${p.surface0.hex}" }

      select_main = { fg = "${p.base.hex}", bg = "${p.green.hex}", bold = true }
      select_alt  = { fg = "${p.green.hex}", bg = "${p.surface0.hex}" }

      unset_main  = { fg = "${p.base.hex}", bg = "${p.flamingo.hex}", bold = true }
      unset_alt   = { fg = "${p.flamingo.hex}", bg = "${p.surface0.hex}" }

      [indicator]
      parent  = { fg = "${p.base.hex}", bg = "${p.text.hex}" }
      current = { fg = "${p.base.hex}", bg = "${p.${accent}.hex}" }
      preview = { fg = "${p.base.hex}", bg = "${p.text.hex}" }

      [status]
      sep_left  = { open = "", close = "" }
      sep_right = { open = "", close = "" }

      progress_label  = { fg = "#ffffff", bold = true }
      progress_normal = { fg = "${p.green.hex}", bg = "${p.surface1.hex}" }
      progress_error  = { fg = "${p.yellow.hex}", bg = "${p.red.hex}" }

      perm_type  = { fg = "${p.${accent}.hex}" }
      perm_read  = { fg = "${p.yellow.hex}" }
      perm_write = { fg = "${p.red.hex}" }
      perm_exec  = { fg = "${p.green.hex}" }
      perm_sep   = { fg = "${p.overlay1.hex}" }

      [input]
      border   = { fg = "${p.${accent}.hex}" }
      title    = {}
      value    = {}
      selected = { reversed = true }

      [pick]
      border   = { fg = "${p.${accent}.hex}" }
      active   = { fg = "${p.pink.hex}" }
      inactive = {}

      [confirm]
      border = { fg = "${p.${accent}.hex}" }
      title  = { fg = "${p.${accent}.hex}" }
      body   = {}
      list   = {}
      btn_yes = { reversed = true }
      btn_no  = {}

      [cmp]
      border = { fg = "${p.${accent}.hex}" }

      [tasks]
      border  = { fg = "${p.${accent}.hex}" }
      title   = {}
      hovered = { fg = "${p.pink.hex}", bold = true }

      [which]
      mask            = { bg = "${p.surface0.hex}" }
      cand            = { fg = "${p.teal.hex}" }
      rest            = { fg = "${p.overlay2.hex}" }
      desc            = { fg = "${p.pink.hex}" }
      separator       = "  "
      separator_style = { fg = "${p.surface2.hex}" }

      [help]
      on      = { fg = "${p.teal.hex}" }
      run     = { fg = "${p.pink.hex}" }
      desc    = { fg = "${p.overlay2.hex}" }
      hovered = { bg = "${p.surface2.hex}", bold = true }
      footer  = { fg = "${p.text.hex}", bg = "${p.surface1.hex}" }

      [notify]
      title_info  = { fg = "${p.teal.hex}" }
      title_warn  = { fg = "${p.yellow.hex}" }
      title_error = { fg = "${p.red.hex}" }

      [filetype]
      rules = [
        { mime = "image/*", fg = "${p.teal.hex}" },
        { mime = "{audio,video}/*", fg = "${p.yellow.hex}" },
        { mime = "application/*zip", fg = "${p.pink.hex}" },
        { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}", fg = "${p.pink.hex}" },
        { mime = "application/{pdf,doc,rtf}", fg = "${p.green.hex}" },
        { mime = "vfs/{absent,stale}", fg = "${p.surface1.hex}" },
        { url = "*", is = "orphan", bg = "${p.red.hex}" },
        { url = "*", is = "exec"  , fg = "${p.green.hex}" },
        { url = "*", is = "dummy", bg = "${p.red.hex}" },
        { url = "*/", is = "dummy", bg = "${p.red.hex}" },
        { url = "*/", fg = "${p.${accent}.hex}" },
      ]

      [spot]
      border   = { fg = "${p.${accent}.hex}" }
      title    = { fg = "${p.${accent}.hex}" }
      tbl_cell = { fg = "${p.${accent}.hex}", reversed = true }
      tbl_col  = { bold = true }
    '';
  };
}
