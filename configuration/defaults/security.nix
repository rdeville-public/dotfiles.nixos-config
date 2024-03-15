{
  ...
}:
{
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo = {
      enable = true;
      execWheelOnly = true;
      extraConfig = ''
        Defaults rootpw
      '';
    };
  };
}


