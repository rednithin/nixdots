{ pkgs, ... }: 
{
    boot.kernelPackages = pkgs.linuxPackages_6_8;

    services.thermald.enable = true;

    # services.auto-cpufreq.enable = true;
    # services.auto-cpufreq.settings = {
    #     battery = {
    #         governor = "powersave";
    #         turbo = "never";
    #     };
    #     charger = {
    #         governor = "performance";
    #         turbo = "auto";
    #     };
    # };

    services.power-profiles-daemon.enable = false;
    services.tlp = {
        enable = true;
    };

    boot.postBootCommands = ''
        #!/bin/bash
        
        for f in /proc/irq/*/smp_affinity_list; do echo 20-21 > $f; done
    '';

    # powerManagement.powertop.enable = true;
}