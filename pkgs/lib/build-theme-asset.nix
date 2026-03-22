# Generic derivation builder for palette-based theme assets.
# Acts like buildCatppuccinPort but takes palette data instead of fetching from GitHub.
{
  lib,
  stdenvNoCC,
}:

lib.extendMkDerivation {
  constructDrv = stdenvNoCC.mkDerivation;

  extendDrvArgs =
    finalAttrs: args:
    args
    // {
      pname = args.pname or "nix-themes-${finalAttrs.app}-${finalAttrs.theme}-${finalAttrs.variant}";
      version = args.version or "0.1.0";

      # No src — content is generated from palette data at eval/build time
      dontUnpack = args.dontUnpack or true;

      meta = {
        description = "Universal ${finalAttrs.app} theme (${finalAttrs.theme}/${finalAttrs.variant})";
        license = lib.licenses.mit;
        platforms = lib.platforms.all;
      }
      // args.meta or { };
    };
}
