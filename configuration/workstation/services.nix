{
  pkgs,
  ...
}:
let
  themes = pkgs.callPackage ../../modules/sddm-theme.nix {};
in
{
  services = {
    # CUPS
    printing = {
      enable = true;
    };

    # Sound
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # X Server
    xserver = {
      enable = true;
      layout = "fr";

      libinput = {
        enable = true;
      };

      displayManager = {
        sddm = {
          enable = true;
          theme = "sddm-theme";
        };
        defaultSession = "none+awesome";
      };

      windowManager = {
        awesome = {
          enable = true;
          luaModules = with pkgs.luaPackages; [
            # The package manager for Lua modules
            luarocks
          ];
        };
      };
    };
  };

  # Install sddm-theme
  environment = {
    # System Wide Packages
    systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      (pkgs.callPackage ../../modules/sddm-theme.nix {}).sddm-theme
    ];
  };
}
