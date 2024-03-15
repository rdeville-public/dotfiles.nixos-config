#  Specific system configuration settings for vm
{
  # lib,
  # config,
  # pkgs,
  # options,
  # stateVersion,
  # vars,
  inputs,
  ...
}:
{
  imports =  [
    ../hosts/nixbox
    ../configuration/defaults
    ../configuration/workstation
    ./nixos-shell.nix
  ];

  users = {
    users = {
      root = {
        password = "root";
      };
    };
  };

}
