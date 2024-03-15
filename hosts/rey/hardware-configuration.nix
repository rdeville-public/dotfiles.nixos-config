#
# Hardware settings for rey laptop
#
{
  config,
  lib,
  pkgs,
  modulesPath,
  host,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel"];
  boot.extraModulePackages = with config.boot.kernelPackages; [ ];

  #swapDevices =
  #  [
  #    { #device = "/dev/disk/by-uuid/7d0c3f66-c6eb-413c-956f-dfdd8ceb0cae";
  #      device = "/dev/disk/by-label/swap";
  #    }
  #  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = with host; {
    useDHCP = false;                            # Deprecated
    hostName = hostName;
    enableIPv6 = false;
    bridges = {                                 # Bridge so interface can be used with virtual machines
      "br0" = {
        interfaces = [ "enp3s0" ];              # enp2s0 without 16x PCI-e populated
      };
    };
    interfaces = {
      # enp2s0 = {                              # Change to correct network driver
      #   #useDHCP = true;                      # Disabled because fixed ip
      #   ipv4.addresses = [ {                  # Ip settings: *.0.50 for main machine
      #     address = "192.168.0.50";
      #     prefixLength = 24;
      #   } ];
      # };
      # wlp1s0.useDHCP = true;                  # Wireless card
      br0.ipv4.addresses = [{
        address = "192.168.0.50";
        prefixLength = 24;
      } ];
    };
    defaultGateway = "192.168.0.1";
    nameservers = [ "192.168.0.4" "1.1.1.1"];   # Pi-Hole DNS
    #nameservers = [ "1.1.1.1" "1.0.0.1" ];     # Cloudflare (when Pi-Hole is down)
  };

  #services.hostapd = {                          # Wifi hotspot
  #  enable = true;
  #  interface = "wlp1s0";
  #  ssid = "h310m";
  #  wpaPassphrase = "<password>";
  #  extraConfig = ''
  #    bridge=br0
  #  '';
  #};
}
