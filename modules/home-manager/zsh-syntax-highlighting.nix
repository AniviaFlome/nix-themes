{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.zsh-syntax-highlighting;
  p = config.themes.palette;
in

{
  options.themes.zsh-syntax-highlighting = themesLib.mkThemeOption {
    name = "Zsh Syntax Highlighting";
  };

  config = lib.mkIf cfg.enable {

    programs.zsh.initContent = lib.mkOrder 950 ''
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
      typeset -gA ZSH_HIGHLIGHT_STYLES

      ZSH_HIGHLIGHT_STYLES[comment]='fg=${p.surface2.hex}'
      ZSH_HIGHLIGHT_STYLES[alias]='fg=${p.green.hex}'
      ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=${p.green.hex}'
      ZSH_HIGHLIGHT_STYLES[global-alias]='fg=${p.green.hex}'
      ZSH_HIGHLIGHT_STYLES[function]='fg=${p.green.hex}'
      ZSH_HIGHLIGHT_STYLES[command]='fg=${p.green.hex}'
      ZSH_HIGHLIGHT_STYLES[precommand]='fg=${p.green.hex},italic'
      ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=${p.peach.hex},italic'
      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=${p.peach.hex}'
      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=${p.peach.hex}'
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=${p.mauve.hex}'
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=${p.green.hex}'
      ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=${p.green.hex}'
      ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=${p.green.hex}'
      ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=${p.red.hex}'
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=${p.red.hex}'
      ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=${p.red.hex}'
      ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=${p.red.hex}'
      ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=${p.yellow.hex}'
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=${p.yellow.hex}'
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=${p.yellow.hex}'
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=${p.maroon.hex}'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=${p.yellow.hex}'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=${p.maroon.hex}'
      ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=${p.yellow.hex}'
      ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=${p.maroon.hex}'
      ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[assign]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[named-fd]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=${p.maroon.hex}'
      ZSH_HIGHLIGHT_STYLES[path]='fg=${p.text.hex},underline'
      ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=${p.red.hex},underline'
      ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=${p.text.hex},underline'
      ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=${p.red.hex},underline'
      ZSH_HIGHLIGHT_STYLES[globbing]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=${p.mauve.hex}'
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=${p.maroon.hex}'
      ZSH_HIGHLIGHT_STYLES[redirection]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[arg0]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[default]='fg=${p.text.hex}'
      ZSH_HIGHLIGHT_STYLES[cursor]='fg=${p.text.hex}'
    '';
  };
}
