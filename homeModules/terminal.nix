{ ... }: {
  programs.kitty = {
    enable = true;

    settings = {
      font_size = 13;
      enable_audio_bell = false;
      scrollback_lines = 100000;
      strip_trailing_spaces = "smart";
      background_opacity = "0.9";
    };
  };
}