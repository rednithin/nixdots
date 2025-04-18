{ config, pkgs, inputs, ... }:

{

  users.users.nithin.shell = pkgs.zsh;

  services.desktopManager.cosmic.enable = true;

  # Configuration for X11 keymap
  services.xserver = {
    enable = true;
    # xkbOptions = "altwin:swap_alt_win";
  };

  users.extraUsers.nithin = {
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.windowManager.awesome.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.flatpak.enable = true;



  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    TERM = "xterm-256color";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # XDG_CURRENT_DESKTOP = "KDE";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };


  programs.fish.enable = true;
  programs.zsh.enable = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  programs.mtr.enable = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  



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
      # floorp = {
      #   executable = "${pkgs.lib.getBin pkgs.floorp}/bin/floorp";
      #   profile = "${pkgs.firejail}/etc/firejail/floorp.profile";
      #  desktop = "${pkgs.floorp}/share/applications/floorp.desktop";
      #   # extraArgs = [ "--browser-allow-drm --browser-disable-u2f=no" ];
      # };
      # chromium = {
      #   executable = "${pkgs.lib.getBin pkgs.chromium}/bin/chromium";
      #   profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
      #   desktop = "${pkgs.chromium}/share/applications/chromium-browser.desktop";
      # };
      google-chrome = {
        executable = "${pkgs.lib.getBin pkgs.google-chrome}/bin/google-chrome-stable";
        profile = "${pkgs.firejail}/etc/firejail/google-chrome.profile";
        desktop = "${pkgs.google-chrome}/share/applications/google-chrome.desktop";
      };
      # brave = {
      #   executable = "${pkgs.lib.getBin pkgs.brave}/bin/brave";
      #   profile = "${pkgs.firejail}/etc/firejail/brave.profile";
      #   desktop = "${pkgs.brave}/share/applications/brave-browser.desktop";
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

  environment.localBinInPath = true;

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


  # Enable sound with pipewire.
  # sound = {
  #   enable = true;
  #   enableOSSEmulation = true;
  #   extraConfig = ''
  #     pcm.ladspa {
  #       type ladspa
  #       slave.pcm "plughw:0,0";
  #       path "${pkgs.ladspaPlugins}/lib/ladspa";
  #       plugins [{
  #         label dysonCompress
  #         input {
  #           # peak limit, release time, fast ratio, ratio
  #           controls [1.0 0.1 0.1 0.9]
  #         }
  #       }]
  #     }
  #   '';
  # };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.pam.services.swaylock = { };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # services.xserver.xautolock = {
  #   enable = true;
  #   enableNotifier = true;
  #   locker = "${pkgs.i3lock}/bin/i3lock -n -c 4B0082";
  #   notify = 10;
  #   time = 1;
  #   notifier = ''${pkgs.libnotify}/bin/notify-send -u critical "Locking Screen" "Locking in 10 seconds"'';
  #   killtime = 10;
  #   extraOptions = [ ''-corners "----" -cornersize 100'' ];
  # };

  programs.ssh.startAgent = true;

  programs.hyprland = {
    enable = true;

    xwayland = {
      enable = true;
    };

    # enableNvidiaPatches = true;
    # xwayland.enable = true;
  };

  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  services.gnome.gnome-keyring.enable = true;


  # systemd = {
  #   services.randomwallpapersvc = {
  #     script = ''
  #       ${pkgs.zsh}/bin/zsh /home/nithin/.dotfiles/dotfiles/scripts/randomwallpaper.sh
  #     '';
  #     description = "Random Wallpaper";
  #     serviceConfig = {
  #       Type = "oneshot";
  #       User = "nithin";
  #     };
  #   };

  #   timers.randomwallpapersvc = {
  #     wantedBy = [ "timers.target" ];
  #     timerConfig.OnCalendar = "minutely";
  #   };
  # };

  imports =
    [
      # Include the results of the hardware scan.
      ./podman.nix
    ];
}
