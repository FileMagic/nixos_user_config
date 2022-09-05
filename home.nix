{ pkgs, ...}: {
        # Packages
        home.packages = with pkgs; [
                ripgrep
                wget
                cargo
                rustc
                nodejs
                jq 
        ];

        # Git
        programs.git = {
                enable = true;
                userName  =  "FileMagic@protonmail.com";
                userEmail = "file_magic";
                extraConfig = {
                        init.defaultBranch = "main";
                        pull.rebase = true;
                };
        };

        # NeoVim Nightly
        nixpkgs.overlays = [
                (import (builtins.fetchTarball {
                url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
                }))
        ];
        programs.neovim = {
                enable = true;
                viAlias = true;
                vimAlias = true;
                package = pkgs.neovim-nightly;
                extraConfig = ''
                        filetype plugin indent on
                        set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
                        set incsearch ignorecase smartcase hlsearch
                        set wildmode=longest,list,full wildmenu
                        set ruler laststatus=2 showcmd showmode
                        set list listchars=trail:»,tab:»-
                        set fillchars+=vert:\
                        set wrap breakindent
                        set encoding=utf-8
                        set textwidth=0
                        set hidden
                        set number
                        set title
                        '';
		plugins = with pkgs.vimPlugins; [
                        vim-surround
                        coc-nvim
                        coc-git
                        coc-highlight
                        coc-python
                        coc-rls
                        coc-vetur
                        coc-yaml
                        coc-html
                        coc-json
                        coc-rust-analyzer
                        vim-nix
                        vimtex
                        fzf-vim
                        nerdtree
                        rainbow
                        ];
        };
}
