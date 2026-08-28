{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    vscode.fhs
    azure-cli
    claude-code
    poetry
  ];
}
