{
  description = "NixOS in MicroVMs";

  # References used by Flake
  inputs = {
    # Default Nix Packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };

    # NixOS MicroVMs
    nixos-shell = {
      url = "github:Mic92/nixos-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Function telling flake which inputs to use
  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-shell
  }:
  let
    # System Architecture
    system = "x86_64-linux";
    stateVersion = "23.11";

    pkgs = import nixpkgs {
      inherit system;
      # Allow Proprietary Software
      config.allowUnfree = true;
    };

    mkSystem = cfg: nixpkgs.lib.makeOverridable nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        nixos-shell.nixosModules.nixos-shell
        ./.
      ];
      specialArgs = {
        inherit
          inputs
          stateVersion
          pkgs
          nixpkgs
          vars;
        cpu = cfg.cpus;
        ram = cfg.ram;
        disk = cfg.disk;
        graphics = cfg.graphics;
        hostName = "nixbox";
      };
    };

    configs =  builtins.map(
      cfg: {
        name = if cfg.graphics
          then
            "c${builtins.toString cfg.cpus}-r${builtins.toString cfg.ram}-g1"
          else
            "c${builtins.toString cfg.cpus}-r${builtins.toString cfg.ram}-g0";
        value = mkSystem cfg;
      }
    ) data;

    defaultDisk = 50;
    data = [
      { cpus = 1; ram = 2; disk = defaultDisk; graphics = false; }
      { cpus = 2; ram = 4; disk = defaultDisk; graphics = false; }
      { cpus = 4; ram = 8; disk = defaultDisk; graphics = false; }
      { cpus = 1; ram = 2; disk = defaultDisk; graphics = true; }
      { cpus = 2; ram = 4; disk = defaultDisk; graphics = true; }
      { cpus = 4; ram = 8; disk = defaultDisk; graphics = true; }
    ];

    vars = {
      defaultUser = "user";
      location = "$HOME/.cache/nix/.setup";
      editor = "nvim";
      terminal = "kitty";
    };
  in
  {
    # Config
    nixosConfigurations = builtins.listToAttrs configs;
  };
}
