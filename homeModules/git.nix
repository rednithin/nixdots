{ ... }: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        User nithin
        Hostname github.com
        PreferredAuthentications publickey
        IdentityFile /home/nithin/.ssh/github
      
      Host gitea.initthyself.xyz
        User nithin
        Hostname gitea.initthyself.xyz
        PreferredAuthentications publickey
        IdentityFile /home/nithin/.ssh/gitea
    '';
  };

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
