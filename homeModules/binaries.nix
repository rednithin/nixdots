{}: {
  home.file = {
    ".local/bin/xdg-open" = {
      text = ''
        #!/usr/bin/env bash
        if [ ! -e /run/.containerenv ] && [ ! -e /.dockerenv ]; then # if not inside a container
            /run/current-system/sw/bin/xdg-open "$@" # run xdg-open normally
        else
            distrobox-host-exec /run/current-system/sw/bin/xdg-open "$@" # run xdg-open on the host
        fi
      '';
      executable = true; # Makes the file executable
    };
  };
}
