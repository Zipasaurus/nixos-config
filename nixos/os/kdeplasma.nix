{ config, pkgs, ... }:

{
  #########################
  # X11 / Wayland / Plasma
  #########################
  services.xserver = {
    enable = true;

    xkb = {
      layout = "gb";
      variant = "";
    };

    videoDrivers = [ "amdgpu" ];

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    desktopManager.plasma6.enable = true;
  };

  #########################
  # Locale / Console
  #########################
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  #########################
  # Audio (PipeWire stack)
  #########################
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
    jack.enable = true;
  };

  #########################
  # Bluetooth
  #########################
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  #########################
  # Graphics
  #########################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
    ];
  };

  #########################
  # Power Management
  #########################
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
    powertop.enable = true;
  };

  services.power-profiles-daemon.enable = true;

  # System76 power stack (safe even on non-System76 hardware)
  hardware.system76.power-daemon.enable = true;
  services.system76-scheduler.enable = true;

  #########################
  # Kernel / AMD tuning
  #########################
  boot = {
    kernelModules = [
      "amdgpu"
      "amd_pstate"
    ];

    kernelParams = [
      "amd_pstate=active"
    ];
  };

  #########################
  # Essential Packages
  #########################
  environment.systemPackages = with pkgs; [
    # KDE
    kdePackages.dolphin
    kdePackages.konsole

    # Shell / UX
    fish
    starship

    # Dev / CLI
    git
    ripgrep
    fd
    bat
    tree
    unzip

    # System tools
    pavucontrol
    brightnessctl
    blueman
    wget
    curl
  ];
}
