{ pkgs, ... }: 
{
    boot.kernelPackages = pkgs.linuxPackages_6_8;

    services.thermald.enable = true;

    services.auto-cpufreq.enable = true;
    services.auto-cpufreq.settings = {
        battery = {
            governor = "powersave";
            turbo = "never";
        };
        charger = {
            governor = "performance";
            turbo = "auto";
        };
    };

    # powerManagement.powertop.enable = true;
}