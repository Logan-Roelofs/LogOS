{ config, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    # Electron
    nodejs_22
    typescript

    # System Utilities
    util-linux # mount kill lsblk etc
    tree # list directory structure
    tldr # Quick help for commands
    git # Version control
    neofetch # System info
    htop # Process viewer
    wget # File downloader
    unzip # Unzip files
    p7zip # 7zip
    ripgrep # Fast file search
    mongosh # MongoDB shell
    updog # Simple HTTP server
    chafa # Image to ASCII
    openvpn # VPN
    netcat # Network utility
    nix-index # Index nix packages
    libxslt # XSLT processor
    home-manager # Home Manager
    terminator # Terminal
    cava
    supabase-cli
    caido
    tt
    espeak
    nixos-generators
    awscli2
    yarn
    figma-linux
    xdg-utils
    nwg-displays
    gh
    inputs.zen-browser.packages."${system}".default

    # Media
    gimp-with-plugins # Image editor
    inkscape-with-extensions

    # GUI Applications
    spotify # Music streaming
    appimage-run # AppImage runner
    slack # Team communication
    teams-for-linux # Unifficial Microsoft Teams client
    discord # Server communication
    sweethome3d.application # Interior design
    sweethome3d.textures-editor # Interior design
    sweethome3d.furniture-editor # Interior design

    # Development
    hugo # Static site generator
    godot_4 # Game engine
    pipenv
    nodejs_23 # Node.js

    #(python3.withPackages (ps: with ps; [ pip requests impacket pyftpdlib ]))
    #inputs.nixpkgs-python.packages.x86_64-linux."2.7"
  ];

  # This is required to run DaVinci Resolve to run on my AMD APU
  hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];
}
