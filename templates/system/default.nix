{ pkgs, lib, inputs, config, ... }:
{
  options = {
    <module_name>.enable = lib.mkEnableOption "Enable <module_name>";
  };

  config = lib.mkIf config.<module_name>.enable {
    # Add config  
  };
}
