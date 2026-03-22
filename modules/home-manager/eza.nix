{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.eza;
  p = config.themes.palette;
  accent = cfg.accent;
  enable = cfg.enable && config.programs.eza.enable;
in

{
  options.themes.eza = themesLib.mkThemeOption {
    name = "eza";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    xdg.configFile."eza/theme.yml".text = ''
      colourful: true

      filekinds:
        normal: {foreground: "${p.text.hex}"}
        directory: {foreground: "${p.${accent}.hex}"}
        symlink: {foreground: "${p.sky.hex}"}
        pipe: {foreground: "${p.subtext1.hex}"}
        block_device: {foreground: "${p.maroon.hex}"}
        char_device: {foreground: "${p.maroon.hex}"}
        socket: {foreground: "${p.subtext1.hex}"}
        special: {foreground: "${p.mauve.hex}"}
        executable: {foreground: "${p.green.hex}"}
        mount_point: {foreground: "${p.teal.hex}"}

      perms:
        user_read: {foreground: "${p.red.hex}", is_bold: true}
        user_write: {foreground: "${p.yellow.hex}", is_bold: true}
        user_execute_file: {foreground: "${p.green.hex}", is_bold: true}
        user_execute_other: {foreground: "${p.green.hex}", is_bold: true}
        group_read: {foreground: "${p.red.hex}"}
        group_write: {foreground: "${p.yellow.hex}"}
        group_execute: {foreground: "${p.green.hex}"}
        other_read: {foreground: "${p.red.hex}"}
        other_write: {foreground: "${p.yellow.hex}"}
        other_execute: {foreground: "${p.green.hex}"}
        special_user_file: {foreground: "${p.mauve.hex}"}
        special_other: {foreground: "${p.overlay1.hex}"}
        attribute: {foreground: "${p.overlay2.hex}"}

      size:
        major: {foreground: "${p.subtext0.hex}"}
        minor: {foreground: "${p.sky.hex}"}
        number_byte: {foreground: "${p.subtext1.hex}"}
        number_kilo: {foreground: "${p.subtext0.hex}"}
        number_mega: {foreground: "${p.blue.hex}"}
        number_giga: {foreground: "${p.mauve.hex}"}
        number_huge: {foreground: "${p.mauve.hex}"}
        unit_byte: {foreground: "${p.subtext0.hex}"}
        unit_kilo: {foreground: "${p.sky.hex}"}
        unit_mega: {foreground: "${p.mauve.hex}"}
        unit_giga: {foreground: "${p.mauve.hex}"}
        unit_huge: {foreground: "${p.teal.hex}"}

      users:
        user_you: {foreground: "${p.text.hex}"}
        user_root: {foreground: "${p.red.hex}"}
        user_other: {foreground: "${p.maroon.hex}"}
        group_yours: {foreground: "${p.subtext0.hex}"}
        group_other: {foreground: "${p.overlay2.hex}"}
        group_root: {foreground: "${p.red.hex}"}

      links:
        normal: {foreground: "${p.${accent}.hex}"}
        multi_link_file: {foreground: "${p.${accent}.hex}"}

      git:
        new: {foreground: "${p.green.hex}"}
        modified: {foreground: "${p.yellow.hex}"}
        deleted: {foreground: "${p.maroon.hex}"}
        renamed: {foreground: "${p.teal.hex}"}
        typechange: {foreground: "${p.pink.hex}"}
        ignored: {foreground: "${p.overlay1.hex}"}
        conflicted: {foreground: "${p.peach.hex}"}

      git_repo:
        branch_main: {foreground: "${p.subtext0.hex}"}
        branch_other: {foreground: "${p.mauve.hex}"}
        git_clean: {foreground: "${p.green.hex}"}
        git_dirty: {foreground: "${p.maroon.hex}"}

      security_context:
        colon: {foreground: "${p.overlay0.hex}"}
        user: {foreground: "${p.overlay1.hex}"}
        role: {foreground: "${p.mauve.hex}"}
        typ: {foreground: "${p.surface2.hex}"}
        range: {foreground: "${p.mauve.hex}"}

      file_type:
        image: {foreground: "${p.yellow.hex}"}
        video: {foreground: "${p.red.hex}"}
        music: {foreground: "${p.green.hex}"}
        lossless: {foreground: "${p.teal.hex}"}
        crypto: {foreground: "${p.overlay1.hex}"}
        document: {foreground: "${p.text.hex}"}
        compressed: {foreground: "${p.pink.hex}"}
        temp: {foreground: "${p.maroon.hex}"}
        compiled: {foreground: "${p.sapphire.hex}"}
        source: {foreground: "${p.${accent}.hex}"}

      punctuation: {foreground: "${p.overlay0.hex}"}
      date: {foreground: "${p.yellow.hex}"}
      inode: {foreground: "${p.subtext0.hex}"}
      blocks: {foreground: "${p.overlay0.hex}"}
      header: {foreground: "${p.text.hex}"}
      octal: {foreground: "${p.teal.hex}"}
      flags: {foreground: "${p.mauve.hex}"}

      symlink_path: {foreground: "${p.sky.hex}"}
      control_char: {foreground: "${p.sapphire.hex}"}
      broken_symlink: {foreground: "${p.red.hex}"}
      broken_path_overlay: {foreground: "${p.surface2.hex}"}
    '';
  };
}
