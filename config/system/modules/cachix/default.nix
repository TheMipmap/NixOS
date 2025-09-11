# WARN: this file will get overwritten by $ cachix use <name>
{ pkgs, lib, ... }:

let
  folder = ./cached_modules;
  toImport = name: value: folder + ("/" + name);
  filterCaches = key: value: value == "regular" && lib.hasSuffix ".nix" key;
  imports = lib.mapAttrsToList toImport (lib.filterAttrs filterCaches (builtins.readDir folder));
in
{
  # Get the cachix pkg
  environment.systemPackages = with pkgs; [ cachix ];

  # Import Cachix caches
  inherit imports;
  nix.settings.substituters = [ "https://cache.nixos.org/" ];
}
