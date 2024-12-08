{ config, pkgs, lib, inputs, username, home-manager, ... }: {
  imports = [
    ./modules/home-manger.nix
    ./modules/vm.nix
    ./modules/tmux.nix
    ./modules/font.nix
    ./modules/apps/linuxapps.nix
    ./modules/apps/defaultapps.nix
    ./modules/apps/securityapps.nix
    ./modules/linux/hyprland.nix
    ./modules/linux/network.nix
    ./modules/linux/ss.nix
  ];

  # Enable envfs for user environments (e.g. /bin)
  services.envfs.enable = true;
  font.packages = [ ... ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  # Remove nixos documentation
  documentation.enable = false;

  # Define Common System Services
  security.polkit.enable = true;
  services.upower.enable = true;

  # enable better shell for all users
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

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
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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
}
