#  Specific system configuration settings for vm
{
  inputs,
  vars,
  ...
}:
{
  imports =  [
    ../../hosts/nixbox
    ../../configuration/defaults
    ../../configuration/workstation
    ./nixos-shell.nix
  ];

  users = {
    users = {
      ${vars.defaultUser} = {
        password = "user";
      };
      root = {
        password = "root";
      };
    };
  };

}
