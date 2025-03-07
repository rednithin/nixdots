{ pkgs, ... }: {
  home.packages =
    (with pkgs; [
      kdePackages.dolphin
      kdePackages.okular
      kdePackages.gwenview
      kdePackages.qtwayland
      kdePackages.breeze
      kdePackages.breeze-gtk
      kdePackages.breeze-icons
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      kdePackages.bluedevil
      kdePackages.ark
      kdePackages.kate
      isoimagewriter
    ]);
}
