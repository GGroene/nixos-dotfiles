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
    go # needed by mason to install gopls
    jdk # needed to run jdtls

    # Needed for lazy.nvim
    nodejs

    # Needed by mason.nvim (unzip for zip-packaged registry entries)
    unzip

    # Formatters used by none-ls
    stylua
    prettier

    # nvim-silicon: renders code screenshots via the `silicon` CLI
    silicon

    # System clipboard integration ("+y/"*y) under X11/qtile
    xclip
  ];

}
