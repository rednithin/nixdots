{ pkgs, ... }:
let
  set-random-wallpaper = pkgs.writeShellScriptBin "set-random-wallpaper" ''
    # export SWWW_TRANSITION_FPS=60
    # export SWWW_TRANSITION_STEP=90 # 2
    # export SWWW_TRANSITION=grow
    # export SWWW_TRANSITION_POS=0.8,0.9

    IMAGE=$(find ~/.dotfiles/Wallpapers -type f | shuf -n 1)
    swww img "$IMAGE"
  '';
  wallpaper-randomizer = pkgs.writeShellScriptBin "wallpaper-randomizer" ''
    while true; do
    	sleep 15
      ${set-random-wallpaper}/bin/set-random-wallpaper
    done
  '';
  init-swww-with-wallpaper = pkgs.writeShellScriptBin "init-swww-with-wallpaper" ''
    swww init
    # ${set-random-wallpaper}/bin/set-random-wallpaper
  '';
in
{
  home.packages = [ pkgs.swww set-random-wallpaper init-swww-with-wallpaper wallpaper-randomizer ];
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once=init-swww-with-wallpaper
    exec-once=wallpaper-randomizer
  '';
}
