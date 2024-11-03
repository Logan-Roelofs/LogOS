{ config, pkgs, lib, inputs, username, home-manager, ... }: {
  imports = [
    ./apps.nix
    ./dev/rust.nix
    ./dev/dev.nix
    ./dev/cpp.nix
    ./dev/js.nix
    ./modules/ss.nix
    ./modules/home-manger.nix
    ./modules/hyprland.nix
    ./modules/network.nix 
    ./modules/vm.nix
    ./modules/control-pannel.nix
  ];

  services.envfs.enable = true; # Enable envfs for user environments (e.g. /bin)

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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

        # rename window
        bind-key r command-prompt -I "#W" "rename-window '%%'"

        # Start windows and panes at 1, not 0
        set -g base-index 1
        setw -g pane-base-index 1

        # switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D
        bind -n M-s select-pane -L
        bind -n M-f select-pane -R
        bind -n M-e select-pane -U
        bind -n M-d select-pane -D

        # don't rename windows automatically
        set-option -g allow-rename off

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
        set -g pane-border-style 'fg=colour6'
        set -g pane-active-border-style 'fg=colour4'

        # statusbar
        set -g status-position bottom
        set -g status-justify left
        set -g status-style 'fg=colour2'
        set -g status-left ' '
        set -g status-right ' '
        #set -g status-right '%Y-%m-%d %H:%M '
        set -g status-right-length 50
        set -g status-left-length 10

        setw -g window-status-current-style 'fg=colour0 bg=colour6 bold'
        setw -g window-status-current-format ' #I #W #F '

        setw -g window-status-style 'fg=colour6 dim'
        setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour6]#F '

        setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'

        # messages
        set -g message-style 'fg=colour2 bg=colour0 bold'
      '';
  };


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
  boot.loader.grub.enable = lib.mkDefault true;
  boot.loader.grub.efiSupport = lib.mkDefault true;
  boot.loader.grub.efiInstallAsRemovable = lib.mkDefault true;
  boot.loader.efi.efiSysMountPoint = lib.mkDefault "/boot";
  boot.loader.grub.device = lib.mkDefault "nodev";
  boot.loader.grub.useOSProber = lib.mkDefault true;
  #  boot.loader.systemd-boot.enable = true;
  #  boot.loader.efi.canTouchEfiVariables = true;
}
