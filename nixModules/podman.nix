{ pkgs, ... }: {
  virtualisation.containers = {
    enable = true;
  };


  # virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = true;
  #   defaultNetwork.settings.dns_enabled = true;
  # };

  virtualisation.docker = {
    enable = true;
    # enableNvidia = true;
    # daemon.settings = {
    #   features = {
    #     cdi = true;
    #   };
    # };
  };

  environment.systemPackages = with pkgs; [
    distrobox
    podman-compose
  ];
}
