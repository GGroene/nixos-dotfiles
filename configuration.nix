{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  services.displayManager.ly.enable = true;
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/nixos-dotfiles/walls/wall1.png
    '';
  };

  services.picom.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  users.users."gg" = {
    isNormalUser = true;
    description = "gg";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      python3 = prev.python3.override {
        packageOverrides = pyFinal: pyPrev: {
          qtile = pyPrev.qtile.overrideAttrs (old: {
            doCheck = false;
            doInstallCheck = false;
          });
        };
      };
      python3Packages = final.python3.pkgs;
    })
  ];

  programs.firefox.enable = true;

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gh
    alacritty
    networkmanagerapplet
    btop
    arandr
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}

