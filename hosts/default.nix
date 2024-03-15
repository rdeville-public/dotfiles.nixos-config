{
  inputs,
  nixpkgs,
  vars,
  ...
}:
let
  # System Architecture
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    # Allow Proprietary Software
    config.allowUnfree = true;
  };

  mkSystem = hostName: nixpkgs.lib.makeOverridable nixpkgs.lib.nixosSystem {
     # Inherit inputs
      inherit system;
      modules = [
        ../configuration/defaults
        ./${hostName}
      ]
      ++
      [
        ../configuration/workstation
      ];

      specialArgs = {
        inherit
          inputs
          pkgs
          hostName
          vars;
      };
    };
in
{
  nixbox = mkSystem "nixbox";
  rey = mkSystem "rey";
}
