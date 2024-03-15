{
  config,
  pkgs,
  cpu,
  ram,
  disk,
  graphics,
  ...
}:
{
  microvm = {
    vcpu = cpu;
    mem = ram * 1024;
    writableStoreOverlay = "/nix/.rw-store";
    graphics.enable = graphics;
    volumes = [
      {
        mountPoint = "/";
        # image = "/tmp/microvm/nixbox.img";
        image = "/home/rdeville/.cache/nix/microvm/nixbox.img";
        size = 20480;
      }
      {
        mountPoint = config.microvm.writableStoreOverlay;
        # image = "/tmp/microvm/store.img";
        image = "/home/rdeville/.cache/nix/microvm/store.img";
        size = 51200;
      }
    ];
    shares = [
      {
        # use "virtiofs" for MicroVMs that are started by systemd
        proto = "9p";
        tag = "ro-store";
        # a host's /nix/store will be picked up so that no
        # squashfs/erofs will be built for it.
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
      {
        # use "virtiofs" for MicroVMs that are started by systemd
        proto = "9p";
        tag = "nixos-config";
        # a host's /nix/store will be picked up so that no
        # squashfs/erofs will be built for it.
        source = "/home/rdeville/git/framagit.org/private/dotfiles/nixos/config";
        mountPoint = "/etc/nixos";
      }
    ];

    hypervisor = "qemu";
    socket = "control.socket";
  };

  networking = {
    hostName = "nixbox";
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;
    netdevs.virbr0.netdevConfig = {
      Kind = "bridge";
      Name = "virbr0";
    };
    networks.virbr0 = {
      matchConfig.Name = "virbr0";
      # Hand out IP addresses to MicroVMs.
      # Use `networkctl status virbr0` to see leases.
      networkConfig = {
        DHCPServer = true;
        IPv6SendRA = true;
      };
      addresses = [ {
        addressConfig.Address = "10.0.0.1/24";
      } {
        addressConfig.Address = "fd12:3456:789a::1/64";
      } ];
      ipv6Prefixes = [ {
        ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
      } ];
    };
    networks.microvm-eth0 = {
      matchConfig.Name = "wlp170s0";
      networkConfig.Bridge = "virbr0";
    };
  };
  # Allow DHCP server
  networking.firewall.allowedUDPPorts = [ 67 ];
  # Allow Internet access
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    internalInterfaces = [ "virbr0" ];
      };
}
