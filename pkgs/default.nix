# Entry point for pkgs/ — palette-based asset builders.
#
# Usage from a module in modules/home-manager/ or modules/nixos/:
#   grubTheme = pkgs.callPackage ../../pkgs/grub/package.nix {
#     inherit palette theme variant;
#   };
{ }
