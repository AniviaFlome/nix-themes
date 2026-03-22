{
  description = "Development Flake for nix-themes";

  inputs = {
    # WARN: This handling of `path:` is a Nix 2.26 feature. The Flake won't work correctly on versions prior to it
    # https://github.com/NixOS/nix/pull/10089
    catppuccin.url = "path:../.";
    nixpkgs.follows = "catppuccin/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    search = {
      url = "github:NuschtOS/search";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      catppuccin,
      search,
      ...
    }@inputs:

    let
      inherit (nixpkgs) lib;
      inherit (inputs.flake-utils.lib) eachDefaultSystem;

      themesHomeModule = catppuccin.homeModules.default;

      # All theme×variant combinations for the test matrix
      themeVariants = {
        catppuccin = [
          "frappe"
          "latte"
          "macchiato"
          "mocha"
        ];
        dracula = [
          "alucard"
          "default"
        ];
        everforest = [
          "dark-hard"
          "dark-medium"
          "dark-soft"
          "light-hard"
          "light-medium"
          "light-soft"
        ];
        gruvbox = [
          "dark-hard"
          "dark-medium"
          "dark-soft"
          "light-hard"
          "light-medium"
          "light-soft"
        ];
        kanagawa = [
          "dragon"
          "lotus"
          "wave"
        ];
        nord = [ "dark" ];
        one-dark = [
          "dark"
          "light"
        ];
        rose-pine = [
          "dawn"
          "main"
          "moon"
        ];
        solarized = [
          "dark"
          "light"
        ];
        tokyo-night = [
          "day"
          "moon"
          "night"
          "storm"
        ];
      };

      # Builds a themes home module for a specific theme+variant combination
      mkThemesHomeModule =
        theme: variant:
        {
          config,
          pkgs,
          ...
        }:
        {
          imports = [
            themesHomeModule
            (catppuccin + "/modules/tests/home.nix")
          ];

          themes.theme = lib.mkForce theme;
          themes.variant = lib.mkForce variant;

          home = {
            homeDirectory = lib.mkDefault (
              if pkgs.stdenv.hostPlatform.isDarwin then
                "/Users/${config.home.username}"
              else
                "/home/${config.home.username}"
            );
            stateVersion = lib.mkDefault "24.11";
          };
        };
    in

    eachDefaultSystem (
      system:

      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Build the themes options doc from the catppuccin/mocha homeConfiguration
        mkThemesOptionsDoc =
          let
            eval = self.homeConfigurations."nix-themes-catppuccin-mocha".extendModules {
              modules = [
                (
                  { lib, ... }:
                  {
                    _module.args.pkgs = lib.mkForce pkgs;
                  }
                )
              ];
            };
            filesLink = "https://github.com/aniviaflome/nix-themes/blob/${
              lib.removeSuffix "-dirty" catppuccin.rev or catppuccin.dirtyRev or "main"
            }";
            rootPath = lib.removeSuffix "/dev/../." inputs.catppuccin.outPath;
            replaceDeclaration = lib.replaceString rootPath filesLink;
          in
          pkgs.nixosOptionsDoc {
            options = { inherit (eval.options) themes; };
            transformOptions =
              opt: lib.recursiveUpdate opt { declarations = map replaceDeclaration opt.declarations; };
          };

        # Generate one check per theme×variant combo
        themesEvalChecks = lib.foldlAttrs (
          acc: theme: variants:
          acc
          // lib.foldl' (
            acc2: variant:
            let
              cfg = self.homeConfigurations."nix-themes-${theme}-${variant}".extendModules {
                modules = [
                  (
                    { lib, ... }:
                    {
                      _module.args.pkgs = lib.mkForce pkgs;
                    }
                  )
                ];
              };
            in
            acc2
            // {
              "themes-eval-${theme}-${variant}" = lib.deepSeq cfg.activationPackage.outPath pkgs.emptyFile;
            }
          ) { } variants
        ) { } themeVariants;
      in

      {
        checks = themesEvalChecks // {
          # Backwards-compat alias
          themes-eval = themesEvalChecks."themes-eval-catppuccin-mocha";
        };

        packages = {
          search = search.packages.${system}.mkSearch {
            baseHref = "/";
            title = "nix-themes Options Search";
            optionsJSON = mkThemesOptionsDoc.optionsJSON + /share/doc/nixos/options.json;
            urlPrefix = "https://github.com/aniviaflome/nix-themes/blob/main/";
          };
          themesOptionsJSON = mkThemesOptionsDoc.optionsJSON;
          themesOptionsMD = mkThemesOptionsDoc.optionsCommonMark;
        };
      }
    )
    // (
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Generate one homeConfiguration per theme×variant combo
        themesHomeConfigurations = lib.foldlAttrs (
          acc: theme: variants:
          acc
          // lib.foldl' (
            acc2: variant:
            acc2
            // {
              "nix-themes-${theme}-${variant}" = inputs.home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                  (mkThemesHomeModule theme variant)
                  { home.username = "nix-themes"; }
                ];
              };
            }
          ) { } variants
        ) { } themeVariants;
      in

      {
        homeConfigurations = themesHomeConfigurations;
      }
    );
}
