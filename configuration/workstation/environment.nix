{
  pkgs,
  ...
}:
{
  environment = {
    # System-Wide Packages
    systemPackages = with pkgs; [
      # Terminal
      kitty             # Terminal Emulator
      xterm             # Fallback Terminal Emulator

      # Audio
      pulseaudio        # Audio Server/Control
      pavucontrol       # CLI Audio Control
      # TODO: @rdeville Change to another in few month as pulsemixer is not
      #       maintained anymore, like ncpamixer
      pulsemixer        # TUI Audio Control
      # TODO: @rdeville Get info about pipewire and qpwgraph sometimes
      # qpwgraph        # Pipewire Graph Manager
      pipewire        # Audio Server/Control

      # Image
      feh               # Image Viewer
      image-roll        # Image Viewer

      # Media Player
      vlc               # Media Player
      mpv               # Media Player

      # Mail Apps
      thunderbird       # Mail/Calendar Client
      neomutt           # Mail/Calendar Client

      # Browser App
      firefox           # Browser
      chromium          # Browser

      # File Management
      zathura           # PDF Viewer
      pcmanfm           # File Browser

      # Other
      keepassxc         # Password Manager
    ];
  };
}
