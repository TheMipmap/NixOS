{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in
{
  options = {
    nvidia = {
      enable = lib.mkEnableOption "enable nvidia module";
      demos.enable = lib.mkEnableOption "enable collection of demos and test programs for OpenGL and Mesa";

      hybrid = {
        enable = lib.mkEnableOption "enable hybrid mode for nvidia module";


        # Use " lspci | grep -E 'VGA | 3D' " to find PCI ID's
        amdgpuBusId = lib.mkOption {
          type = lib.types.str;
          default = "PCI:63:0:0";
          description = "Bus ID of integrated AMD GPU for PRIME";
        };

        nvidiaBusId = lib.mkOption {
          type = lib.types.str;
          default = "PCI:1:0:0";
          description = "Bus ID of NVIDIA GPU for PRIME";
        };

      };
    };
  };

  config = lib.mkIf config.nvidia.enable {

    # Enable OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    };

    # Set VA-API decode to use NVIDIA card
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ] ++ lib.optional config.nvidia.hybrid.enable "amdgpu";

    # NVIDIA kernel modules at boot
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings` through terminal or `NVIDIA X Server` in programs GUI
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # Hybrid mode: 
    # - Use the amd iGPU for most stuff by default
    # - Use 'nvidia-offload' for programs that should use the nvidia dGPU.
    hardware.nvidia.prime = lib.mkIf config.nvidia.hybrid.enable {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # Integrated gpu
      amdgpuBusId = config.nvidia.hybrid.amdgpuBusId;

      # Dedicated gpu
      nvidiaBusId = config.nvidia.hybrid.nvidiaBusId;
    };

    # Blacklist nouveau package (bad open-source nvidia drivers)
    boot.blacklistedKernelModules = [ "nouveau" ];

    # Install dependencies
    environment.systemPackages = dependencies
      ++ (if (config.nvidia.demos.enable or false) then with pkgs; [ mesa-demos ] else [ ]);

  };
}
