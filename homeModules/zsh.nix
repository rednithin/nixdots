{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # enableAutosuggestions = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 500000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      # theme = "af-magic"; # blinks is also really nice
    };
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      character = {
        success_symbol = "[»](bold green)";
        error_symbol = "[»](bold red)";
      };

      container = {
        symbol = "⇉";
        format = "[$symbol $name ]($style)";
        style = "bold #FF4D00";
      };
    };
  };
}
