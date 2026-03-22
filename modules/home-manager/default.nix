{ lib, ... }:

{
  _class = "homeManager";

  imports = [
    (lib.modules.importApply ../global.nix { themesModules = import ./all-modules.nix; })
  ];
}
