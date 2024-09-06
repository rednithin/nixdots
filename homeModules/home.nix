{ pkgs, pkgs-unstable, lib, config, ... }:

{

  nixpkgs.config.allowUnfree = true;

  home.username = "nithin";
  home.homeDirectory = "/home/nithin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages =
    let
      zsh-fhs = pkgs.buildFHSUserEnv {
        name = "zshfhs";
        targetPkgs = pkgs:
          with pkgs; [
            curl
          ];
        runScript = "zsh";
      };
    in
    (with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # firefox
      # chromium
      # Programming related
      git
      nil
      nixd
      direnv
      ripgrep
      nodejs_20
      nodePackages.pnpm
      yarn-berry
      bun
      mongodb-tools
      sqlite
      sqlitebrowser
      turso-cli
      sqld
      pm2
      vulkan-tools
      vulkan-loader
      vulkan-headers
      bruno
      beekeeper-studio
      distrobox


      # Non-programming related
      zsh-fhs
      htop
      neofetch
      wget
      curl
      nerdfonts
      sshpass
      kitty
      bat
      zellij
      eza
      fd
      starship
      zoxide
      hyperfine
      xorg.xprop
      xautolock
      libnotify
      i3lock
      gparted
      brightnessctl
      iperf
      mongodb-compass
      hplip
      swww
      waybar
      grim
      grimblast
      xwayland
      wl-clipboard
      cliphist
      pavucontrol
      networkmanagerapplet
      mako
      wf-recorder
      alacritty
      killall
      pamixer
      tailscale
      wlr-randr
      upower
      pulseaudio
    ]) ++ (with pkgs-unstable; [
      helix
    ]);


  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./zsh.nix
    ./hyprland/default.nix
    ./waybar/default.nix
    ./swww.nix
    ./awesome.nix
    ./binaries.nix
    ./cursor.nix
    ./gtk.nix
    ./lockscreen.nix
    ./flameshot.nix
  ];
}
