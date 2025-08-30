{ lib, config, ... }:
let
  cfg = config.gaming;
in
{
  imports = [
    ./lutris
    ./minecraft
    ./proton
    ./steam
  ];
}
