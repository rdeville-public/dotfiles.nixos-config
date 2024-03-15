{
  pkgs,
  ...
}:
{
  # Fonts
  fonts.packages = with pkgs; [
    # NixOS
    carlito
    vegur
    source-code-pro
    jetbrains-mono
    # Icons
    font-awesome
    # MS
    # Nerdfont Icons override
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];
}
