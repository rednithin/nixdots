{ pkgs, ... }: 
{
    boot.kernelPackages = pkgs.linuxPackages_6_9;

    services.thermald.enable = true;
    powerManagement.enable = true;

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
        settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 80;

            #Optional helps save long term battery health
            # START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
            # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
        };
    };

    boot.postBootCommands = ''
        #!/bin/bash
        
        for f in /proc/irq/*/smp_affinity_list; do echo 20-21 > $f; done
    '';

    # powerManagement.powertop.enable = true;
}