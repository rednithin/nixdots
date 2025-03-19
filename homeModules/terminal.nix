{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    settings = {
      font_size = 14;
      font_family = "FantasqueSansM Nerd Font";
      enable_audio_bell = false;
      scrollback_lines = 100000;
      strip_trailing_spaces = "smart";
      background_opacity = "0.85";
      background_blur = 1;
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor.softwrap = true;
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
    themes = {
    };
  };



}
