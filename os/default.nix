{ config, pkgs, lib, inputs, username, ... }: {
  imports = [
    ./apps.nix
    ./vm.nix
    ./dev/rust.nix
    ./dev/dev.nix
    ./dev/cpp.nix
    ./dev/js.nix
    ./ss.nix
    ./home-manger.nix
    ./stylix.nix
  ];

  networking.extraHosts = ''
    10.10.11.230 cozyhosting.htb
  '';

  services.envfs.enable = true; # Enable envfs for user environments (e.g. /bin)

  programs.tmux = {
    enable = true;
    extraConfig =
      # conf
      ''
        # remap prefix from 'C-b' to 'C-a'
        unbind C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Enable mouse control (clickable windows, panes, resizable panes)
        set -g mouse on

        set -g allow-passthrough on
        bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e; send-keys -M'"
        # DESIGN TWEAKS

        # don't do anything when a 'bell' rings
        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        setw -g monitor-activity off
        set -g bell-action none

        # clock mode
        setw -g clock-mode-colour colour1

        # copy mode
        setw -g mode-style 'fg=colour1 bg=colour18 bold'

        # pane borders
        set -g pane-border-style 'fg=colour1'
        set -g pane-active-border-style 'fg=colour3'

        # statusbar
        set -g status-position bottom
        set -g status-justify left
        set -g status-style 'fg=colour2'
        set -g status-left ' '
        set -g status-right ' '
        #set -g status-right '%Y-%m-%d %H:%M '
        set -g status-right-length 50
        set -g status-left-length 10

        setw -g window-status-current-style 'fg=colour2 bg=colour1 bold'
        setw -g window-status-current-format ' #I #W #F '

        setw -g window-status-style 'fg=colour1 dim'
        setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour1]#F '

        setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'

        # messages
        set -g message-style 'fg=colour2 bg=colour0 bold'
      '';
  };

  networking.firewall.enable = false;

  # Hyprland Configuration

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables.KITTY_DISABLE_WAYLAND = "1";
  # Define Common System Fonts
  fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    nerdfonts
    monaspace
  ];

  # Remove nixos documentation
  documentation.enable = false;

  # Define Common System Services
  security.polkit.enable = true;
  services.upower.enable = true;

  programs.zsh.enable = true;
  # Define Main User
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Define Time Settings
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define Network Settings
  networking.hostName = "NixOS";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Define Nixos Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  # Define Audio Settings
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define Kernel Settings
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define Bootloader Settings
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  #  boot.loader.systemd-boot.enable = true;
  #  boot.loader.efi.canTouchEfiVariables = true;
}
