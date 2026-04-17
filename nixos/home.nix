{ config, pkgs, ... }:
{
  home.username = "zip";
  home.homeDirectory = "/home/zip";
  home.stateVersion = "25.05";


  # Hyprland config – make sure you have programs.hyprland.enable = true; somewhere (or in system config)
  wayland.windowManager.hyprland = {
    enable = true;  # ← add this if missing

    settings = {
      env = [
        "XCURSOR_SIZE,24"
        # Optional extras that often help with cursor issues:
        "HYPRCURSOR_SIZE,24"
      ];

      # ... your other Hyprland settings here ...
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
  };

  # If you manage Waybar via home-manager too, add this:
  # programs.waybar = {
  #   enable = true;
  #   # settings + style here...
  # };
}
