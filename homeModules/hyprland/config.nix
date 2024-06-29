{ ... }: 
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {

      env = [
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_STYLE_OVERRIDE,qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_MENU_PREFIX,plasma-"

        "CLUTTER_BACKEND,wayland"
        "GDK_SCALE,1"
        "GDK_BACKEND,wayland"
        "LIBSEAT_BACKEND,logind"
        "LIBVA_DRIVER_NAME,radeonsi"
        "LIBVA_DRIVER_NAME,nvidia"
        # "GBM_BACKEND,nvidia-drm" # Firefox crashes when enabled
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "NIXOS_OZONE_WL,1"
        "MOZ_ENABLE_WAYLAND,1"
        "SDL_VIDEODRIVER,wayland"
      ];

      monitor= [
        "DVI-D-1, 2450x1440, 1920x0, 1"
        "HDMI-A-1, 1920x1080, 0x0, 1"
        "Unknown-1, disable"
      ];
      
      # autostart
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "/usr/lib/polkit-kde-authentication-agent-1"

        
        "waybar &"
        "swww init &"
        "sleep 2 && swww img ~/.dotfiles/Wallpapers/wallhaven-2e3kw6.jpg &"
        "wl-paste --type text --watch cliphist store &"
        "wl-paste --type image --watch cliphist store &"
        # "nm-applet &"
        # "hyprctl setcursor Nordzy-cursors 22 &"
        "mako &"
        "hyprctl setcursor Nordzy-cursors 30 &"
        "~/.dotfiles/dotfiles/scripts/launch.sh"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      general = {
        "$mainMod" = "SUPER";
        layout = "dwindle";
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgb(cba6f7) rgb(94e2d5) 45deg";
        "col.inactive_border" = "0x00000000";
        border_part_of_window = false;
        no_border_on_floating = false;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
      };

      xwayland = {
        force_zero_scaling = "true";
      };

      dwindle = {
        no_gaps_when_only = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_is_master = true;
      };

      decoration = {
        rounding = 5;
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];

        animation = [
          # Windows
          "windowsIn, 1, 3, easeOutCubic, popin 30%" # window open
          "windowsOut, 1, 3, fluent_decel, popin 70%" # window close.
          "windowsMove, 1, 2, easeinoutsine, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
          "fadeOut, 1, 2, easeOutCubic" # fade out (close) -> layers and windows
          "fadeSwitch, 0, 1, easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow, 1, 10, easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim, 1, 4, fluent_decel" # the easing of the dimming of inactive windows
          "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
          "borderangle, 1, 30, fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces, 1, 4, easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      bind = [
        # show keybinds list
        "$mainMod, F1, exec, show-keybinds"

        # keybindings
        "$mainMod, Return, exec, alacritty"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen, 0"
        "$mainMod, Space, togglefloating,"
        "$mainMod, P, exec, pkill wofi || wofi --show drun"
        "$mainMod, Escape, exec, swaylock"
        "$mainMod, T, togglesplit,"
        "$mainMod SHIFT, B, exec, pkill -SIGUSR1 .waybar-wrapped"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod CTRL, R, exec, hyprctl reload && pkill waybar && waybar &,"
        "$mainMod CTRL, Q, exec, swaylock -n -c 4B0082,"

        # screenshot
        "$mainMod, Print, exec, grimblast --notify --cursor save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"
        ",Print, exec, grimblast --notify --cursor  copy area"

        # switch focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # switch workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # same as above, but switch to the workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        "$mainMod CTRL, c, movetoworkspace, empty"

        # window control
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod CTRL, left, resizeactive, -80 0"
        "$mainMod CTRL, right, resizeactive, 80 0"
        "$mainMod CTRL, up, resizeactive, 0 -80"
        "$mainMod CTRL, down, resizeactive, 0 80"
        "$mainMod ALT, left, moveactive,  -80 0"
        "$mainMod ALT, right, moveactive, 80 0"
        "$mainMod ALT, up, moveactive, 0 -80"
        "$mainMod ALT, down, moveactive, 0 80"


        # move workspace
        "$mainMod CTRL, left, movecurrentworkspacetomonitor, l"
        "$mainMod CTRL, right, movecurrentworkspacetomonitor, r"

        # media and volume controls
        ",XF86AudioRaiseVolume,exec, ~/.dotfiles/dotfiles/scripts/volume.sh up"
        ",XF86AudioLowerVolume,exec, ~/.dotfiles/dotfiles/scripts/volume.sh down"
        ",XF86AudioMute,exec, ~/.dotfiles/dotfiles/scripts/volume.sh mute"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        # laptop brigthness
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
        "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"

        # clipboard manager
        "$mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
      ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # windowrule
      windowrule = [
        "float,imv"
        "center,imv"
        "size 1200 725,imv"
        "float,mpv"
        "center,mpv"
        "tile,Aseprite"
        "size 1200 725,mpv"
        "float,title:^(float_kitty)$"
        "center,title:^(float_kitty)$"
        "size 950 600,title:^(float_kitty)$"
        "float,audacious"
        "workspace 8 silent, audacious"
        "pin,wofi"
        "float,wofi"
        "noborder,wofi"
        "tile, neovide"
        "idleinhibit focus,mpv"
        "float,udiskie"
        "float,title:^(Transmission)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "size 700 450,title:^(Volume Control)$"
        "move 40 55%,title:^(Volume Control)$"
      ];

      # windowrulev2
      windowrulev2 = [
        "float, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override, class:(Aseprite)"
        "opacity 1.0 override 1.0 override, class:(Unity)"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(SoundWireServer)$"
        "float,class:^(.sameboy-wrapped)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
      ];
    };
  };
}