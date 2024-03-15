#  Specific system configuration settings for vm
{
  pkgs,
  ...
}:
{
  imports =  [
    ./hardware-configuration.nix
  ];

  system = {
    stateVersion = "23.11";
  };

  # Boot Options
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
      };
      timeout = 1;
    };
    tmp = {
      cleanOnBoot =  true;
      tmpfsSize = "5GB";
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  environment = {
    # System Wide Packages
    systemPackages = with pkgs; [
      # Test Package
      hello
    ];
  };
}
