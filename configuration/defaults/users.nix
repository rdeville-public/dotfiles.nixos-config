# System User
{
  pkgs,
  inputs,
  vars,
  ...
}:
{
  users = {
    defaultUserShell = pkgs.zsh;
  };

  users = {
    users = {
      ${vars.defaultUser} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
  };

  programs = {
    zsh = {
      enable = true;
    };
  };
}

