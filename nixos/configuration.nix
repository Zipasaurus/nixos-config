{ config, pkgs, ... }:

{
  time.timeZone = "Europe/London";
  #########################
  # Base / Hardware / Themes
  #########################
  imports =
  [
    ./hardware-configuration.nix
    ./themes.nix
    ./pkgs.nix           # All non-Hyprland packages and GNOME/X11 apps
    #Below-is-for-operating-systems
    ./os/hyprland.nix
    #./os/awesome.nix
    # ./os/kdeplasma.nix 
  ];
     environment.pathsToLink = [
  "/share/applications"
  "/share/xdg-desktop-portal"
];
   #########################
  # Bootloader
  #########################
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";          # Required for UEFI
      useOSProber = true;        # Detect other OSes for multi-boot
    };
  };

  #########################
  # Swap & zram
  #########################
  zramSwap = {
    enable = true;
    memoryPercent = 50;          # ~16 GB compressed
    algorithm = "zstd";          # Better compression ratio
    priority = 100;              # High priority
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16384;               # 16 GiB
      # randomEncryption.enable = true;  # Optional
      # priority = -1;                  # Lower than zram if using both
    }
  ];

  #########################
  # Networking & Firewall
  #########################
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  networking.firewall.allowedTCPPorts = [ 5960 5961 5962 5963 5964 5965 5966 4444 ];
  networking.firewall.allowedUDPPorts = [  5353 4444 ];
  networking.firewall.enable = true;
  services.flatpak.enable = true;  
 services.syncthing = {
	enable = true;
	user = "zip";
	dataDir = "/home/zip/Documents/syncthing";
       };  

  #########################
  # Kernel / Hardware tweaks
  #########################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ mesa ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
   services.devmon.enable = true;
services.gvfs.enable = true; 
services.udisks2.enable = true;
  boot.kernelModules = ["amd_pstate" "amdgpu"];
  boot.kernelParams = ["amd_pstate=active" "usbcore.autosuspend=-1"];
  networking.interfaces.tailscale0 = {
  mtu = 1280;
  };
  #########################
  # File Systems / Mounts
  #########################
  boot.supportedFilesystems = [ "ntfs" "ntfs3" ];

  fileSystems = {
    "/mnt/tailscaleSamba" = {
      device = "//100.91.160.124/Shared";
      fsType = "cifs";
      options = [
        "username=zip"
        "password=277353"
        "uid=1000"
        "gid=100"
        "vers=3.0"
        "sec=ntlmssp"
        "nounix"
        "noserverino"
        "cache=loose"
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "x-systemd.device-timeout=5s"
      ];
    };
    "/mnt/samba" = {
      device = "//192.168.4.100/Shared";
      fsType = "cifs";
      options = [
        "username=zip"
        "password=277353"
        "uid=1000"
        "gid=1000"
        "iocharset=utf8"
        "noperm"
        "nofail"
      ];
    };
  };
  #########################
  # Users
  #########################
  users.users.zip = {
    isNormalUser = true;
    description = "zipasaurus";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  #########################
  # Locale & Keymaps
  #########################
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";
  nixpkgs.config.allowUnfree = true;

  #########################
  # System version
  #########################
  system.stateVersion = "25.05"; 
}
