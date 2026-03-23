# nix-themes

Vibe coded experimental fork of [catppuccin/nix](https://github.com/catppuccin/nix) that supports more color palettes.

Supports **10 color schemes** with multiple variants each:

| Theme | Variants |
|---|---|
| catppuccin | latte, frappe, macchiato, mocha |
| dracula | default, alucard |
| everforest | dark-hard, dark-medium, dark-soft, light-hard, light-medium, light-soft |
| gruvbox | dark-hard, dark-medium, dark-soft, light-hard, light-medium, light-soft |
| kanagawa | wave, dragon, lotus |
| nord | dark |
| one-dark | dark, light |
| rose-pine | main, moon, dawn |
| solarized | dark, light |
| tokyo-night | storm, night, moon, day |

## Quick Start

Add the flake input:

```nix
inputs.nix-themes.url = "github:aniviaflome/nix-themes";
```

Import the module in your Home Manager or NixOS configuration:

```nix
# Home Manager
imports = [ inputs.nix-themes.homeModules.default ];

# NixOS
imports = [ inputs.nix-themes.nixosModules.default ];
```

Enable and configure:

```nix
themes = {
  enable = true;
  theme = "catppuccin";   # one of the 10 theme names above
  variant = "mocha";      # a variant for the chosen theme
  accent = "blue";        # accent color
};
```

All supported apps will automatically receive consistent theming. You can also enable or disable per app:

```nix
themes.kitty.enable = true;
themes.waybar.enable = false;
```

## License

MIT — see [LICENSE](LICENSE)
