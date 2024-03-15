{
  pkgs,
  vars,
  ...
}:
{
  environment = {
    # Environment Variables
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };

    # System-Wide Packages
    systemPackages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      htop              # Process Manager
      coreutils         # GNU Utilities
      git               # Version Control
      killall           # Process Killer
      lshw              # Hardware Config
      nix-tree          # Browse Nix Store
      pciutils          # Manage PCI
      smartmontools     # Disk Health
      tldr              # Helper
      usbutils          # Manage USB
      wget              # Retriever
      curl              # Retriever
      xdg-utils         # Environment integration
      tmux              # Terminal Multiplexer

      # Text Editor
      neovim            # Text Editor

      # File Management
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      zip               # Zip

      # Utilities
      jq
    ];
  };
}
