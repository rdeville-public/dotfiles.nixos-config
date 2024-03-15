{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  # References used by Flake
  inputs = {
    # Default Nix Packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };
    # Hardware Specific configuration
    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };
    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Function telling flake which inputs to use
  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  }:
  let
    # Vars used in Flakes
    vars = {
      defaultUser = "user";
      location = "$HOME/.cache/nix/.setup";
      editor = "nvim";
      terminal = "kitty";
    };
  in
  {
    # hosts = (builtins.attrNames (builtins.readDir ./hosts));
    # NixOS Config
    nixosConfigurations = (
      import ./. {
        # Inherit inputs
        inherit
          inputs
          nixpkgs
          nixos-hardware
          vars;
      }
    );

    # Nix Configurations
    # homeConfigurations = (
    #   import ./nix {
    #     inherit (nixpkgs) lib;
    #     inherit inputs nixpkgs nixpkgs-unstable home-manager nixgl vars;
    #   }
    # );
  };
}

