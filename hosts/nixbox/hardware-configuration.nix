{
  lib,
  config,
  hostName,
  ...
}:
{
  boot = {
    initrd = {
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "virtio_pci"
        "floppy"
        "sr_mod"
        "virtio_blk"
      ];
      kernelModules = [];
    };
    kernelModules = [
      "kvm-intel"
    ];
    extraModulePackages = [];
  };

  # Root filesystem
  fileSystems."/" = {
   device = "/dev/disk/by-label/nixos";
   fsType = "ext4";
  };

  # Swap filesystem
  swapDevices = [];

  networking = with hostName; {
    hostName = hostName;
    interfaces = {
      eth0 = {
        useDHCP = true;
      };
    };
  };

  hardware = {
    cpu = {
      intel = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
