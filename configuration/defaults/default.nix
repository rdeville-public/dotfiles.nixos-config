{
  inputs,
  pkgs,
  vars,
  ...
}:
{
  imports = [
    ./console.nix
    ./environment.nix
    ./fonts.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
    ./time.nix
    ./users.nix
  ];
}
