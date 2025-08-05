{ lib, config, ... }:
let
  cfg = config.gaming;
in
{
  imports = [
    ./steam
    ./minecraft
  ];
}
