{ config, pkgs, ... }:

{
  #########################
  # Hyprland / Wayland
  #########################
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Autologin into Hyprland on TTY1
  services.getty.autologinUser = "zip";
  environment.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      start-hyprland
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
  # PipeWire & Audio
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
  # Hyprland Utilities
  #########################
  environment.systemPackages = with pkgs; [
    # Wayland / Hyprland Essentials
    waybar
    hypridle
    hyprlock
    hyprpaper
    wofi
    dunst
    wl-clipboard
    cliphist
    grim
    slurp
    grimblast
    xdg-desktop-portal-hyprland
    xdg-utils
    unzip
    blueman
    brightnessctl
    playerctl
    protonup-ng
    kitty
    fish
    fzf
    starship
    git
    pavucontrol
    crosspipe
    easyeffects
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
