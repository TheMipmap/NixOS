{ lib, config, ... }:
let
  cfg = config.gaming;
in
{
  imports = [
    ./heroic
    ./minecraft
    ./proton
    ./steam
  ];
}
