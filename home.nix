{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    rofi = "rofi";
    alacritty = "alacritty";
    picom = "picom";
  };
in

{
  imports = [
    ./modules/neovim.nix
    ./modules/work.nix
    ./modules/theme.nix
  ];
  home.username = "gg";
  home.homeDirectory = "/home/gg";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  # programs.bash = {
  #   enable = true;
  #   shellAliases = {
  #     btw = "echo i use nixos-btw";
  #     nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
  #   };
  #   initExtra = ''
  #     	  export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
  #     	'';
  # };
  programs.fish.enable = true;

  programs.git = {
    settings = {
      user = {
        name = "Gijs Groeneveld";
        email = "gijsgroeneveld@msn.com";
      };
      init.defaultBranch = "main";
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    gcc
    rofi
    rofi-power-menu
    xwallpaper
    maim
    i3lock
    starship
    tmux
    pcmanfm
    kdePackages.filelight
  ];

}
