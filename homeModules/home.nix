{ pkgs, ... }:

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
      zsh-fhs = pkgs.buildFHSEnv {
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
      # beekeeper-studio
      # bruno
      bun
      direnv
      distrobox
      git
      mongodb-tools
      nil
      nixd
      nodePackages_latest.pnpm
      nodejs_23
      deno
      pm2
      ripgrep
      sqld
      sqlite
      sqlitebrowser
      turso-cli
      vulkan-headers
      vulkan-loader
      vulkan-tools
      yarn-berry


      # Non-programming related
      alacritty
      bat
      brightnessctl
      cliphist
      curl
      eza
      fd
      gparted
      grim
      grimblast
      # hplip
      htop
      hyperfine
      i3lock
      iperf
      killall
      libnotify
      mako
      mongodb-compass
      fastfetch
      nerd-fonts.noto
      nerd-fonts.ubuntu
      nerd-fonts.iosevka
      nerd-fonts.zed-mono
      nerd-fonts.fira-mono
      nerd-fonts.fira-code
      nerd-fonts.inconsolata
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.jetbrains-mono
      networkmanagerapplet
      pamixer
      pavucontrol
      pulseaudio
      sshpass
      starship
      swww
      # tailscale
      upower
      waybar
      wf-recorder
      wget
      wl-clipboard
      wlr-randr
      rofi-wayland
      xautolock
      xorg.xprop
      xwayland
      zellij
      zoxide
      zsh-fhs
      wezterm
      helix
      vscode-fhs
      zed-editor

      xdg-utils
      pass
      oha
    ]);


  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./awesome.nix
    ./binaries.nix
    ./cursor.nix
    ./flameshot.nix
    ./git.nix
    ./gtk.nix
    ./hyprland/default.nix
    # ./kde.nix
    ./lockscreen.nix
    ./swww.nix
    ./waybar/default.nix
    ./zsh.nix
    ./terminal.nix
    ./firejailicons.nix
  ];
}
