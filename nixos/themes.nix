{ config, pkgs, ... }:

{
  # Install themes system-wide
  environment.systemPackages = with pkgs; [
    gnome-themes-extra
    adwaita-icon-theme
  ];

  # Cursor theme (Wayland + X11)
  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # Fonts (define ONCE)
  fonts = {
    fontconfig.enable = true;

    packages = with pkgs; [
      dejavu_fonts
      jetbrains-mono
      font-awesome
    ];
  };
}
