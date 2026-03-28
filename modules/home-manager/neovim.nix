{ themesLib }:
{ config, lib, ... }:
let
  cfg = config.catppuccin.nvim;

  defaultConfig = {
    compile_path = lib.generators.mkLuaInline "compile_path";
    flavour = cfg.flavor; # TODO: flavor → variant; verify palette supports this variant
  };
in
{
  options.catppuccin.nvim = themesLib.mkThemeOption { name = "neovim"; } // {
    settings = lib.mkOption {
      description = "Extra settings that will be passed to the setup function.";
      default = { };
      type = lib.types.submodule { freeformType = lib.types.attrsOf lib.types.anything; };
      apply = lib.recursiveUpdate defaultConfig;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      plugins = [
        {
          # plugin = config.catppuccin.sources.nvim; # TODO: replace with inline palette-based generation
          config = ''
            lua << EOF
              local compile_path = vim.fn.stdpath("cache") .. "/catppuccin-nvim"
              vim.fn.mkdir(compile_path, "p")
              vim.opt.runtimepath:append(compile_path)

              require("catppuccin").setup(${lib.generators.toLua { } cfg.settings})

              vim.api.nvim_command("colorscheme catppuccin")
            EOF
          '';
        }
      ];
    };
  };
}
