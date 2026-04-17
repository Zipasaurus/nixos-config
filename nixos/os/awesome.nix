{ config, pkgs, ... }:

{
  #########################
  # AwesomeWM / X11
  #########################
  services.xserver.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.displayManager.lightdm.enable = true;  # optional DM for autologin

  # Optional: autologin without display manager
  services.getty.autologinUser = "zip";
  environment.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      startx
    fi
  '';

  #########################
  # Keymaps / Locales
  #########################
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  console.keyMap = "uk";
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  #########################
  # Audio
  #########################
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  #########################
  # AwesomeWM Utilities
  #########################
  environment.systemPackages = with pkgs; [
    # Awesome essentials
    awesome
    xterm
    kitty
    fish
    fzf
    starship
    git
    pavucontrol
    easyeffects
    brightnessctl
    blueman
    wl-clipboard     # optional, mostly for clipboard tools even in X11
    unzip
    ripgrep
    fd
    bat
    tree
    wget
    curl
    cava
  ];

  #########################
  # Graphics / GPU
  #########################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ mesa ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  #########################
  # System / Power / Kernel tweaks
  #########################
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
  powerManagement.enable = true;
  boot.kernelModules = ["amd_pstate" "amdgpu"];
  boot.kernelParams = ["amd_pstate=active"];
}
