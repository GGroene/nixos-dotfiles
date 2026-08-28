{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };

    # Keep GTK4 apps on the same theme (home-manager 26.05 changed the default
    # to null instead of inheriting gtk.theme).
    gtk4.theme = config.gtk.theme;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    # Qt apps follow the GTK theme above (Dracula ships a matching gtk-2.0 dir).
    platformTheme.name = "gtk";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Dracula";
      icon-theme = "Dracula";
      color-scheme = "prefer-dark";
    };
  };
}
