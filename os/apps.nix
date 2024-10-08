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
    blueberry # Bluetooth manager
    openvpn # VPN
    yazi # Terminal file manager
    imagemagick # Image support for nvim
    luajitPackages.magick # Image support for nvim
    netcat # Network utility
    nix-index # Index nix packages
    libxslt # XSLT processor
    networkmanagerapplet
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

    # neovim          # Text editor
    gvfs # Virtual file system
    hyprlock
    flavours
    # Emulators and Game Managment
    #steam-rom-manager # Steam ROM Manager
    #steam           # Steam
    #attract-mode    # frontend for emulators
    #xemu            # xbox emulator
    #pcsx2           # ps2 emulator
    #rpcs3           # ps3 emulator
    #ryujinx         # switch emulator
    #dolphin-emu     # gamecube and wii emulator
    #retroarchFull   # multi-system emulator

    # Media
    #davinci-resolve # Video Editor
    obs-studio # Streaming and recording
    ffmpeg # Video and audio processing
    gimp-with-plugins # Image editor
    grimblast # Screenshot tool
    grim # Screenshot tool
    slurp # Screenshot tool
    wl-clipboard
    wl-clipboard-x11 # Clipboard manager
    inkscape-with-extensions

    # Security Tools
    rustscan # Fast port scanner
    nmap # Network scanner
    john # Password cracker
    hashcat # Password cracker
    hash-identifier # Hash identifier
    burpsuite # Web application security testing
    samba # Smb client
    inetutils # telnet, ftp, rsh, rlogin, rcp, and rwho
    redis # Redis-cli
    gobuster # Directory brute-forcer
    enum4linux # Enumerate information from Windows and Samba systems
    thc-hydra # Password cracker
    whatweb # Web scanner
    exploitdb # Exploit database
    ffuf # Fast web fuzzer
    cewl # Custom word list generator
    nfs-utils # NFS client
    dig # DNS lookup
    theharvester # Email, subdomain, and people search

    # GUI Applications
    spotify # Music streaming
    remmina # Remote desktop client
    appimage-run # AppImage runner
    slack # Team communication
    teams-for-linux # Unifficial Microsoft Teams client
    discord # Server communication
    rofi-wayland # Application launcher
    sweethome3d.application # Interior design
    sweethome3d.textures-editor # Interior design
    sweethome3d.furniture-editor # Interior design

    # Development
    hugo # Static site generator
    godot_4 # Game engine
    pipenv

    # Desktop Package Requirements
    hyprpicker # Hyprland color picker
    fd # Fast file search
    bun # js run time
    dart-sass # sass compiler
    brightnessctl # Brightness control
    supergfxctl # Sway wallpaper
    slurp # Screenshot tool
    loupe # Sway wallpaper
    gnome.adwaita-icon-theme # Icon theme
    gnome.nautilus # File manager
    gnome.gnome-system-monitor # System monitor
    gnome.gnome-control-center # System settings

    (python3.withPackages (ps: with ps; [ pip requests impacket pyftpdlib ]))
    inputs.nixpkgs-python.packages.x86_64-linux."2.7"
  ];
  programs.steam.enable = true;

  # This is required to run DaVinci Resolve to run on my AMD APU
  hardware.opengl.extraPackages = with pkgs; [ rocmPackages.clr.icd ];
}
