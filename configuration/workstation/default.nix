{
  pkgs,
  vars,
  ...
}:
{
  imports = [
    ./environment.nix
    ./hardware.nix
    ./services.nix
    ./users.nix
  ];
}
