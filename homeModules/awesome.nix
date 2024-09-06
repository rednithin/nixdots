{...}: {
  home.file.".config/awesome" = {
    recursive = true;
    source = ../dotfiles/awesome;
  };
}
