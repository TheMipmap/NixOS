{ lib, config, ... }:
let
  cfg = config.gaming;
in
{
  imports = [
    ./proton
    ./steam
    ./minecraft
  ];
}
