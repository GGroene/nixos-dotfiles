{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      dracula-theme.theme-dracula
    ];
  };

  home.packages = with pkgs; [
    azure-cli
    claude-code
    poetry
  ];
}
