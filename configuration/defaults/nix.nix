{
  pkgs,
  inputs,
  ...
}:
{
  # Nix Package Manager Settings
  nix = {
    settings ={
      auto-optimise-store = true;
    };
    # Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    # Enable Flakes
    package = pkgs.nixVersions.unstable;
    registry = {
      nixpkgs = {
        flake = inputs.nixpkgs;
      };
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
}
