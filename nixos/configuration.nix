{ config, pkgs, ... }:

{
  time.timeZone = "Europe/London";



  imports =
  [
    ./hardware-configuration.nix
   ./themes.nix
   ./pkgs.nix   
   ./os/hyprland.nix
    #./os/awesome.nix
    # ./os/kdeplasma.nix 
  ];
     environment.pathsToLink = [
  "/share/applications"
  "/share/xdg-desktop-portal"
];
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";         
      useOSProber = true;       
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;         
    algorithm =  "zstd";         
    priority = 100;             
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16384;             
    }
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
   networking.firewall = {
    allowedTCPPorts = [
      5959
      5960
      5961
    ];
    allowedTCPPortRanges = [
      {
        from = 6960;
        to = 8000;
      }
      {
        from = 7960;
        to = 9000;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 6960;
        to = 8000;
      }
      {
        from = 7960;
        to = 9000;
      }
    ];
  };
  services.avahi = {
      enable = true;
      openFirewall = true;
      nssmdns6 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
  networking.firewall.enable = true;
  services.flatpak.enable = true;  
 services.syncthing = {
	enable = true;
	user = "zip";
	dataDir = "/home/zip/Documents/syncthing";
       };  

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
  users.users.zip = {
    isNormalUser = true;
    description = "zipasaurus";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11"; 
}
