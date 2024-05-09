{ config, pkgs, lib, inputs, username, ... }:
{
  imports = [
    ./apps.nix
    ./shell.nix
    ./theme.nix
    ./vm.nix
    ./dev/rust.nix
    ./dev/dev.nix
    ./dev/cpp.nix
    ./dev/js.nix
    ./ss.nix
    ./home-manger.nix
  ];

  networking.extraHosts =
    ''
      10.10.11.230 cozyhosting.htb
    '';

  programs.tmux = {
    enable = true;
    extraConfig = ''
    set -g allow-passthrough on
    set -g mouse on  
    bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e; send-keys -M'"
    '';
  };

  networking.firewall.enable = false;

 Hyprland Configuration
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Define Common System Fonts
  fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    nerdfonts
  ];

  # Remove nixos documentation
  documentation.enable = false;

  # Define Common System Services
  security.polkit.enable = true;
  services.upower.enable = true;

  # Define Main User 
  users.users.${username} = {
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
