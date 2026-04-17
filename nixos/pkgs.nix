{ config, pkgs, ... }:

{
  #########################
  # General / Non-Hyprland Apps
  #########################
  environment.systemPackages = with pkgs; [

    # GNOME / Desktop Apps
    kdePackages.dolphin         # File manager (non-Hyprland specific)
    mission-center              # System utility
    kdePackages.kio-extras
    kdePackages.kio
  android-file-transfer
    # Browsers / Development
    firefox
    vscode
    unityhub
    kdePackages.kdenlive	
    # Communication / Social
    discord
    spotify
    tailscale

    # System Utilities
    btop
    gvfs
    cifs-utils
    networkmanagerapplet
    udiskie
    rustdesk
    ndi
    # Terminal Utilities
    ripgrep
    fd
    bat
    tree
    wget
    curl
    krita

    # File Management / Archives
    zip
    unrar
    p7zip
    cava
    syncthingtray
    # Games / Steam / OBS placeholders
    steam
    prismlauncher
    beammp-launcher
    heroic
    gamescope
    gamemode
    mangohud
    protontricks
    moonlight-qt
    # OBS / Streaming
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs
         distroav
  	 obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-gstreamer
        obs-vaapi
        obs-vkcapture
        obs-websocket
        obs-shaderfilter
        obs-composite-blur
        obs-scale-to-sound
        obs-move-transition
      ];
    })
  ];

  #########################
  # Programs / Services
  #########################
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
}
