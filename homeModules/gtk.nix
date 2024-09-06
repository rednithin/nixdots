{ pkgs, ... }: {
  gtk = {
    enable = true;
    font = { name = "NotoSans Nerd Font"; };
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    iconTheme = {
      package = pkgs.kdePackages.breeze-icons;
      name = "Breeze Dark";
    };
    cursorTheme = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 26;
    };
  };
}
