{ config, pkgs, inputs, ... }:

{
  imports = 
  [ 
    inputs.home-manager.nixosModules.default
  ];

  users.users.nithin.shell = pkgs.fish;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.windowManager.awesome.enable = true;
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  
  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "KDE";
  };


  programs.fish.enable = true; 
  
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  programs.mtr.enable = true;


  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      nithin = {
        imports = [ ./home.nix ];
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    extraOptions = ''--insecure-registry "http://139.59.219.55:5000"'';
  };
  users.users.nithin.extraGroups = [ "docker" ];

  
  
  security.chromiumSuidSandbox.enable = true;
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      firefox = {
        executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        desktop = "${pkgs.firefox}/share/applications/firefox.desktop";
        # extraArgs = [ "--browser-allow-drm --browser-disable-u2f=no" ];
      };
      chromium = {
        executable = "${pkgs.lib.getBin pkgs.chromium}/bin/chromium";
        profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
        desktop = "${pkgs.chromium}/share/applications/chromium-browser.desktop";
      };
      spotify = {
        executable = "${pkgs.lib.getBin pkgs.spotify}/bin/spotify";
        profile = "${pkgs.firejail}/etc/firejail/spotify.profile";
        desktop = "${pkgs.spotify}/share/applications/spotify.desktop";
      };
      # steam = {
      #   executable = "${pkgs.lib.getBin pkgs.steam}/bin/steam";
      #   profile = "${pkgs.firejail}/etc/firejail/steam.profile";
      #   desktop = "${pkgs.steam}/share/applications/steam.desktop";
      # };
      # steam-run = {
      #   executable = "${pkgs.lib.getBin pkgs.steam-run}/bin/steam-run";
      #   profile = "${pkgs.firejail}/etc/firejail/steam-run.profile";
      #   # desktop = "${pkgs.steam-run}/share/applications/steam-run.desktop";
      # };
    };
  };
  
  # environment.etc."firejail/firejail.config".source = pkgs.runCommandNoCC "firejail.config" {} ''
  #   sed ${pkgs.firejail}/etc/firejail/firejail.config -e "s/# browser-allow-drm no/browser-allow-drm yes/;s/# browser-disable-u2f yes/browser-disable-u2f no/;" > $out
  # '';

 
  environment.etc."firejail/firefox.local".text = ''
    ignore noexec ''${HOME}
    ignore noroot
  '';

  # environment.etc."firejail/steam.local".text = ''
  #   whitelist ''${HOME}/HDD
  # '';


  programs.firefox.preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
  };

  nix.optimise.automatic = false;
  nix.optimise.dates = [ "03:45" ];

  
  nix.gc = {
    automatic = false;
    dates = "weekly";
    options = "--delete-older-than 90d";
  };


  # security.apparmor = {
  #   enable = true;
  #   enableCache = true;
  #   killUnconfinedConfinables = true;
  #   packages = [pkgs.apparmor-profiles];
  #   policies = {
  #     "firejail-default" = {
  #       profile = "${pkgs.firejail}/etc/apparmor.d/firejail-default";
  #       enable = true;
  #     };
  #   };
  # };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  fileSystems."/home/nithin/HDD" = { 
    device = "/dev/disk/by-uuid/9f66e623-f475-40ad-8a7c-97518b4f0656";
    fsType = "ext4";
  };


  services.xserver.xautolock = {
    enable = true;
    enableNotifier = true;
    locker = "${pkgs.i3lock}/bin/i3lock -n -c 4B0082";
    notify = 10;
    time = 1;
    notifier = ''${pkgs.libnotify}/bin/notify-send -u critical "Locking Screen" "Locking in 10 seconds"'';
    killtime = 10;
    extraOptions = [ ''-corners "----" -cornersize 100'' ];
  };
}