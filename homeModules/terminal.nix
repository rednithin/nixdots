{ ... }: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    settings = {
      font_size = 14;
      font_family = "FantasqueSansM Nerd Font Mono Regular";
      enable_audio_bell = false;
      scrollback_lines = 100000;
      strip_trailing_spaces = "smart";
      background_opacity = "0.85";
      background_blur = 1;
    };
  };
}
