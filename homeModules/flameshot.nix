{ pkgs-unstable, ... }: {
  services.flameshot = {
    enable = true;
    package = pkgs-unstable.flameshot.override {
      enableWlrSupport = true;
    };
  };
}