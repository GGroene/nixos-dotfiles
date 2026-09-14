{ config, pkgs, lib, ... }:

{
  # Install Neovim and dependencies
  home.packages = with pkgs; [
    neovim

    # Tools required for Telescope
    ripgrep
    fd
    fzf

    # Needed by nvim-treesitter to compile parsers ("tree-sitter build")
    tree-sitter

    # Language Servers
    lua-language-server
    nil # nix language server
    nixpkgs-fmt # nix formatter
    go
    gopls # go language server

    # Needed for lazy.nvim
    nodejs

    # Needed by mason.nvim (unzip for zip-packaged registry entries)
    unzip

    # Formatters used by none-ls
    stylua
    prettier
  ];

}
