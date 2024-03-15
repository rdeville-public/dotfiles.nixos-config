{
  config,
  cpu,
  ram,
  disk,
  graphics,
  ...
}:
{
  virtualisation = {
    cores = cpu;
    memorySize = ram * 1024;
    diskSize = disk * 1024;
    graphics = graphics;
    writableStore = true;
    useNixStoreImage = false;
    writableStoreUseTmpfs = false;
    libvirtd = {
      enable = true;
    };
    sharedDirectories = {
      nixos = {
        source = "/home/rdeville/git/framagit.org/private/dotfiles/nixos";
        target = "/home/rdeville/git/framagit.org/private/dotfiles/nixos";
      };
      nix-store = {
        source = "/nix/store";
        target = "/nix/store";
      };
    };
    diskImage = "../${config.system.name}.qcow2";
  };

  programs = {
    virt-manager = {
      enable = true;
    };
  };
  nixos-shell = {
    mounts = {
      mountHome = false;
      mountNixProfile = false;
    };
  };
}
