{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.broot;
  p = config.themes.palette;
  accent = cfg.accent;
  themeFile = "nix-themes-${config.themes.theme}-${config.themes.variant}-${accent}.hjson";
  enable = cfg.enable && config.programs.broot.enable;

  rgb = c: "rgb(${toString c.rgb.r}, ${toString c.rgb.g}, ${toString c.rgb.b})";
in

{
  options.themes.broot = themesLib.mkThemeOption {
    name = "broot";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    programs.broot.settings.imports = [
      {
        file = "skins/${themeFile}";
        luma = "light";
      }
      {
        file = "skins/${themeFile}";
        luma = [
          "dark"
          "unknown"
        ];
      }
    ];

    xdg.configFile."broot/skins/${themeFile}".text = ''
      skin: {
        default: ${rgb p.text} none / ${rgb p.subtext1} none
        tree: ${rgb p.${accent}} none / ${rgb p.surface2} none
        parent: ${rgb p.surface2} none / ${rgb p.surface1} none
        file: ${rgb p.text} none / ${rgb p.subtext1} none
        directory: ${rgb p.${accent}} none Bold / ${rgb p.subtext0} none bold
        exe: ${rgb p.green} none
        link: ${rgb p.teal} none
        pruning: ${rgb p.overlay0} none Italic
        perm__: ${rgb p.surface2} none
        perm_r: ${rgb p.sky} none
        perm_w: ${rgb p.maroon} none
        perm_x: ${rgb p.green} none
        owner: ${rgb p.lavender} none
        group: ${rgb p.mauve} none
        count: ${rgb p.peach} ${rgb p.surface1}
        dates: ${rgb p.sapphire} none
        sparse: ${rgb p.yellow} none
        content_extract: ${rgb p.teal} none
        content_match: ${rgb p.green} none
        device_id_major: ${rgb p.lavender} none
        device_id_sep: ${rgb p.surface2} none
        device_id_minor: ${rgb p.lavender} none

        git_branch: ${rgb p.${accent}} none
        git_insertions: ${rgb p.green} none
        git_deletions: ${rgb p.red} none
        git_status_current: ${rgb p.subtext1} none
        git_status_modified: ${rgb p.yellow} none
        git_status_new: ${rgb p.sky} none Bold
        git_status_ignored: ${rgb p.surface2} none
        git_status_conflicted: ${rgb p.red} none
        git_status_other: ${rgb p.red} none

        selected_line: none ${rgb p.surface1} / none ${rgb p.surface0}
        char_match: ${rgb p.green} none Bold
        file_error: ${rgb p.red} none

        flag_label: ${rgb p.subtext1} none
        flag_value: ${rgb p.${accent}} none Bold

        input: ${rgb p.text} none / ${rgb p.subtext1} ${rgb p.surface1}

        status_error: ${rgb p.text} ${rgb p.red}
        status_job: ${rgb p.yellow} ${rgb p.surface1}
        status_normal: ${rgb p.text} ${rgb p.surface1}
        status_italic: ${rgb p.${accent}} ${rgb p.surface1} Italic
        status_bold: ${rgb p.${accent}} ${rgb p.surface1} Bold
        status_code: ${rgb p.rosewater} ${rgb p.surface1}
        status_ellipsis: ${rgb p.subtext1} ${rgb p.surface1}

        purpose_normal: ${rgb p.text} ${rgb p.surface0}
        purpose_italic: ${rgb p.yellow} ${rgb p.surface0} Italic
        purpose_bold: ${rgb p.yellow} ${rgb p.surface0} Bold
        purpose_ellipsis: ${rgb p.text} ${rgb p.surface0}

        scrollbar_track: ${rgb p.surface2} none / ${rgb p.surface1} none
        scrollbar_thumb: ${rgb p.surface1} none / ${rgb p.surface0} none

        help_paragraph: ${rgb p.text} none
        help_bold: ${rgb p.${accent}} none Bold
        help_italic: ${rgb p.maroon} none Italic
        help_code: ${rgb p.text} ${rgb p.surface1}
        help_headers: ${rgb p.${accent}} none
        help_table_border: ${rgb p.surface2} none

        preview_title: ${rgb p.subtext1} none / ${rgb p.surface0} none
        preview: ${rgb p.text} ${rgb p.surface1} / ${rgb p.subtext1} ${rgb p.surface0}
        preview_separator: ${rgb p.${accent}} none / ${rgb p.surface2} none
        preview_line_number: ${rgb p.subtext0} ${rgb p.surface1}
        preview_match: none ${rgb p.green}

        hex_null: ${rgb p.overlay0} none
        hex_ascii_graphic: ${rgb p.surface2} none
        hex_ascii_whitespace: ${rgb p.yellow} none
        hex_ascii_other: ${rgb p.peach} none
        hex_non_ascii: ${rgb p.red} none

        staging_area_title: ${rgb p.subtext1} none / ${rgb p.surface0} none
        mode_command_mark: ${rgb p.surface1} ${rgb p.red} Bold

        good_to_bad_0: ${rgb p.green}
        good_to_bad_1: ${rgb p.green}
        good_to_bad_2: ${rgb p.green}
        good_to_bad_3: ${rgb p.teal}
        good_to_bad_4: ${rgb p.yellow}
        good_to_bad_5: ${rgb p.peach}
        good_to_bad_6: ${rgb p.peach}
        good_to_bad_7: ${rgb p.maroon}
        good_to_bad_8: ${rgb p.red}
        good_to_bad_9: ${rgb p.red}
      }
    '';
  };
}
