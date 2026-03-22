{
  description = "Universal theme manager for Nix — Catppuccin, Dracula, Gruvbox, Nord, and more";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:

    let
      inherit (nixpkgs) lib;

      # Systems for development related outputs
      devSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllDevSystems = lib.genAttrs devSystems;

      mkModule =
        {
          name ? "default",
          type,
          file,
        }:
        { ... }:
        {
          _file = "${self.outPath}/flake.nix#${type}Modules.${name}";
          imports = [ file ];
        };
    in

    {
      homeModules = {
        default = self.homeModules.themes;
        themes = mkModule {
          name = "themes";
          type = "homeManager";
          file = ./modules/home-manager;
        };
      };

      nixosModules = {
        default = self.nixosModules.themes;
        themes = mkModule {
          name = "themes";
          type = "nixos";
          file = ./modules/nixos;
        };
      };

      devShells = forAllDevSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        lib.genAttrs [ "default" "ci" ] (
          name:
          import ./shell.nix {
            inherit pkgs;
            minimal = name == "ci";
          }
        )
      );

      formatter = forAllDevSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.treefmt.withConfig {
          runtimeInputs = with pkgs; [
            keep-sorted
            nixfmt
          ];

          settings = {
            on-unmatched = "info";
            tree-root-file = "flake.nix";

            formatter = {
              keep-sorted = {
                command = "keep-sorted";
                excludes = [ "*.sh" ];
                includes = [ "*" ];
              };
              nixfmt = {
                command = "nixfmt";
                includes = [ "*.nix" ];
              };
            };
          };
        }
      );
    };
}
