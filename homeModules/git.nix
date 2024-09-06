{}: {
  home.file.".ssh/config".text = ''
    Host github.com
      User nithin
      Hostname github.com
      PreferredAuthentications publickey
      IdentityFile /home/nithin/.ssh/github
  '';

  programs.git = {
    enable = true;
    userName = "Nithin Reddy";
    userEmail = "reddy.nithinpg@gmail.com";
    extraConfig = {
      credential = {
        helper = "store";
      };
    };
  };
}
