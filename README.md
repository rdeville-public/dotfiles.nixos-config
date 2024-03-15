# Nixos Configuration

My nixos configuration.

Currently in development, this repos aims later store most configuration of my
computers running under NixOS.

To validate configuration and/or starting a VMs using nix, you need :

  * nix package manager
  * nixos-shell
  * support of nix flakes
  * qemu
  * jq

Easiest way to use this configuration to run an VMs under NixOs is to use
script `start.sh` at the root of this repos.

Simply run the script using command `./start.sh` then select VMs configuration
you want to run.

