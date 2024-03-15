{
  vars,
  ...
}:
{
  users = {
    users = {
      ${vars.defaultUser} = {
        isNormalUser = true;
        extraGroups = [
          "video"
          "audio"
          "camera"
          "lp"
          "scanner"
        ];
      };
    };
  };
}
