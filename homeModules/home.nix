{ pkgs, pkgs-unstable, lib, config, ... }:

{

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nithin";
  home.homeDirectory = "/home/nithin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # firefox
    # chromium
    hello
    zip
    unzip
    htop
    neofetch
    screenfetch
    wget
    curl
    vscode
    git
    kate
    lapce
    nil
    direnv
    ripgrep
    nodejs_20
    nodePackages.pnpm
    yarn-berry
    # floorp
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    nerdfonts
    sshpass
    bun
    nitrogen
    wezterm
    bat
    zellij
    eza
    fd
    starship
    zoxide
    hyperfine
    xorg.xprop
    xautolock
    flameshot
    davinci-resolve-studio
    libnotify
    i3lock
    insomnia
    gparted
    isoimagewriter
    brightnessctl
    blanket
    iperf
    mongodb-compass
    mongodb-tools
    sqlite
    sqlitebrowser
    hplip
    libsForQt5.polonium

    swww
    waybar
    grim
    grimblast

    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    xwayland
    wl-clipboard
    cliphist

    wofi
    pavucontrol
    networkmanagerapplet
    
    mako
    wf-recorder
    alacritty
    killall
    pamixer
    swaylock
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ]) ++ (with pkgs-unstable; [
    helix
    postman
  ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nithin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName  = "Nithin Reddy";
    userEmail = "reddy.nithinpg@gmail.com";
    extraConfig = {
      credential = {
        helper = "store";
      };
    };
  };

  home.file = {
    ".config/awesome" = {
      recursive = true;
      source = ../dotfiles/awesome;
    };

    # ".steam/steam/steam_dev.cfg".text = ''
    #   unShaderBackgroundProcessingThreads 12
    # '';

    ".ssh/config".text = ''
      Host github.com
        User nithin
        Hostname github.com
        PreferredAuthentications publickey
        IdentityFile /home/nithin/.ssh/github
    '';
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 65;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 15 seconds' -t 10000";
      }
      {
        timeout = 70;
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        timeout = 85;
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
    systemdTarget = "hyprland-session.target";
  };
  
  # systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

  imports = [
    ./zsh.nix
    ./hyprland/default.nix
    ./waybar/default.nix
  ];
}
