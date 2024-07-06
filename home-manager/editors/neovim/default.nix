{ config, pkgs, configDir, ... }:
{
  # HACK: manix
  # https://github.com/nix-community/manix/issues/18
  manual.json.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaPackages = ps: [ ps.jsregexp ];
    extraPackages = with pkgs; [
      # for compiling Treesitter parsers
      gcc

      # debuggers
      lldb # comes with lldb-vscode

      # formatters and linters
      nixfmt-classic
      rustfmt
      shfmt
      stylua
      statix
      luajitPackages.luacheck
      prettierd

      # LSP servers
      nil
      rust-analyzer
      taplo
      gopls
      lua
      shellcheck
      marksman
      sumneko-lua-language-server
      nodePackages_latest.typescript-language-server
      yaml-language-server

      # this includes css-lsp, html-lsp, json-lsp, eslint-lsp
      nodePackages_latest.vscode-langservers-extracted

      # other utils and plugin dependencies
      gnumake
      src-cli
      ripgrep
      fd
      sqlite
      lemmy-help
      fzf
      cargo
      cargo-nextest
      clippy
      glow
      mysql
    ];
  };

  xdg.configFile = {
    nvim = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/se7en-nvim";
      recursive = true;
    };
    ripgrep_ignore.text = ''
      .git/
      yarn.lock
      package-lock.json
      packer_compiled.lua
      .DS_Store
      .netrwhist
      dist/
      node_modules/
      **/node_modules/
      wget-log
      wget-log.*
      /vendor
    '';
  };

}
