{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  
    # Web Browsers
    firefox         # Firefox
    chromium        # Chromium

    # System Utilities
    util-linux      # mount kill lsblk etc
    tree            # list directory structure
    tldr            # Quick help for commands
    git             # Version control
    neofetch        # System info
    htop            # Process viewer
    wget            # File downloader
    unzip           # Unzip files
    p7zip           # 7zip
    kitty           # The CLI itself
    gparted         # Partition manager
    ripgrep         # Fast file search   

    # Emulators and Game Managment
    steam-rom-manager # Steam ROM Manager
    steam           # Steam
    attract-mode    # frontend for emulators
    xemu            # xbox emulator
    pcsx2           # ps2 emulator
    rpcs3           # ps3 emulator
    ryujinx         # switch emulator
    dolphin-emu     # gamecube and wii emulator
#    retroarchFull   # multi-system emulator

    # Media
#    davinci-resolve # Video Editor
    obs-studio      # Streaming and recording
    ffmpeg          # Video and audio processing

    # Security Tools
    rustscan        # Fast port scanner
    nmap            # Network scanner
    john            # Password cracker
    hashcat         # Password cracker
    hash-identifier # Hash identifier
    burpsuite       # Web application security testing
    samba           # Smb client
    inetutils       # telnet, ftp, rsh, rlogin, rcp, and rwho
    redis           # Redis-cli

    # GUI Applications
    spotify         # Music streaming
    remmina         # Remote desktop client
    vscode          # Code editor
    appimage-run    # AppImage runner
    slack           # Team communication
    teams-for-linux # Unifficial Microsoft Teams client
    discord         # Server communication

    #looking-glass-client # GPU accelerated KVM
    #obs-studio-plugins.looking-glass-obs # Looking Glass OBS plugin

    # Development
    hugo            # Static site generator


    # Virtualization
    virt-manager   # Virtualization manager
    ];

  # This is required to run DaVinci Resolve to run on my AMD APU
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
}
