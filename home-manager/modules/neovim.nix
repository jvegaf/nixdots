{ lib, pkgs, ... }: {
  # AIDEV-NOTE: Migrated from neovim-config (LazyVim) to nvf - 2026-03-25
  programs.nvf = {
    enable = true;

    # Neovim package
    package = pkgs.neovim-unwrapped;

    settings = {
      # ═══════════════════════════════════════════════════════════════════════════
      # BASIC VIM OPTIONS (migrated from lua/config/options.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      vim = {
        # Leader keys
        mapleader = " ";
        maplocalleader = ",";

        # Editing options
        clipboard = "unnamedplus";
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
        smartindent = true;
        
        # UI options
        cmdheight = 2;
        cursorline = true;
        number = true;
        relativenumber = true;
        numberwidth = 4;
        signcolumn = "yes";
        foldcolumn = "1";
        foldenable = true;
        foldlevel = 10;
        foldlevelstart = 99;
        laststatus = 3;
        showtabline = 2;
        showmode = true;
        pumheight = 15;
        
        # Search options
        hlsearch = true;
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        
        # Terminal options
        shell = "zsh";
        termguicolors = true;
        
        # Misc options
        mouse = "a";
        title = true;
        undofile = true;
        updatetime = 300;
        timeoutlen = 500;
        backup = false;
        writebackup = false;
        swapfile = false;
        splitbelow = true;
        splitright = true;
        wrap = false;
        completeopt = [ "menuone" "noselect" ];
        sidescrolloff = 8;
        ruler = true;
        showcmd = true;
        conceallevel = 0;
        encoding = "utf-8";
        fileencoding = "utf-8";

        # Winbar
        winbar = "%=%m %f";

        # Filetype
        filetype = {
          plugin = true;
          indent = true;
        };
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # COLORSCHEME - ayu (from lua/plugins/colorscheme.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      colorscheme = "ayu";

      # ═══════════════════════════════════════════════════════════════════════════
      # LSP SUPPORT (from lua/plugins/lspconfig.lua + lazyvim extras)
      # ═══════════════════════════════════════════════════════════════════════════
      lsp = {
        enable = true;
        formatOnSave = true;
      };

      # Language servers and tools
      languages = {
        # TypeScript/JavaScript
        ts = {
          enable = true;
          lsp = true;
          format = {
            type = "biome";
          };
        };
        
        # JSON
        json = {
          lsp = true;
        };
        
        # HTML
        html = {
          enable = true;
        };
        
        # CSS
        css = {
          enable = true;
          format = {
            type = "biome";
          };
        };
        
        # Markdown
        markdown = {
          enable = true;
          treesitter = true;
          lsp = true;
        };
        
        # TOML
        toml = {
          lsp = true;
          format = true;
        };
        
        # Docker
        docker = {
          enable = true;
          lsp = true;
        };
        
        # Git
        git = {
          enable = true;
        };
        
        # Python
        python = {
          enable = true;
          lsp = {
            enable = true;
          };
          format = {
            type = "ruff";
          };
        };
        
        # C/C++
        clangd = {
          enable = true;
          lsp = {
            package = "clangd";
          };
        };
        
        # Nix
        nix = {
          enable = true;
          lsp = {
            enable = true;
          };
          format = {
            type = "nixfmt";
          };
        };
        
        # Rust
        rust = {
          enable = true;
          lsp = {
            enable = true;
          };
        };
        
        # Go
        go = {
          enable = true;
          lsp = {
            enable = true;
          };
        };
        
        # Lua
        lua = {
          enable = true;
          lsp = {
            enable = true;
          };
        };
        
        # YAML
        yaml = {
          enable = true;
          lsp = true;
        };
        
        # Tailwind CSS
        tailwindcss = {
          enable = true;
        };
        
        # Clang (C/C++)
        c = {
          enable = true;
          lsp = {
            package = "clangd";
          };
        };
        
        # C++
        cpp = {
          enable = true;
          lsp = {
            package = "clangd";
          };
        };
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # TREESITTER (from lua/plugins/treesitter.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      treesitter = {
        enable = true;
        ensureInstalled = [
          "tsx"
          "typescript"
          "java"
          "xml"
          "yaml"
          "html"
          "css"
          "json"
          "lua"
          "markdown"
          "markdown_inline"
          "bash"
          "python"
          "rust"
          "go"
          "c"
          "cpp"
          "nix"
          "dockerfile"
          "vim"
          "vimdoc"
        ];
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # COMPLETION - blink.cmp
      # ═══════════════════════════════════════════════════════════════════════════
      completion = {
        enable = true;
        package = "blink";
        minChars = 2;
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # DAP - Debug Adapter Protocol (from lazyvim extras)
      # ═══════════════════════════════════════════════════════════════════════════
      dap = {
        enable = true;
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # UI PLUGINS
      # ═══════════════════════════════════════════════════════════════════════════
      ui = {
        # Statusline
        statusline = {
          enable = true;
        };
        
        # Icons
        icons = {
          enable = true;
        };
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # TERMINAL - toggleterm (from lua/plugins/toggleterm.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      terminal = {
        enable = true;
        toggleterm = {
          enable = true;
        };
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # KEYMAPS (from lua/config/keymaps.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      keymaps = [
        # Exit insert mode
        { key = "jk"; mode = "i"; action = "<ESC>"; opts = { noremap = true; silent = true; }; }
        
        # Save and quit
        { key = "<leader>wq"; mode = "n"; action = ":wq<CR>"; opts = { noremap = true; silent = true; }; }
        { key = "<leader>q"; mode = "n"; action = ":q!<CR>"; opts = { noremap = true; silent = true; }; }
        
        # Save
        { key = "W"; mode = "n"; action = ":w<CR>"; opts = { noremap = true; silent = true; }; }
        
        # Close buffer
        { key = "Q"; mode = "n"; action = ":bdelete<CR>"; opts = { noremap = true; silent = true; }; }
        
        # Buffer navigation
        { key = "H"; mode = "n"; action = ":BufferLineCyclePrev<cr>"; opts = { noremap = true; silent = true; }; }
        { key = "L"; mode = "n"; action = ":BufferLineCycleNext<cr>"; opts = { noremap = true; silent = true; }; }
        
        # Visual paste (don't yank)
        { key = "p"; mode = "v"; action = "\"_dP"; opts = { noremap = true; silent = true; }; }
        
        # Select all
        { key = "<C-a>"; mode = "n"; action = "gg<S-v>G"; opts = { noremap = true; silent = true; }; }
        
        # Stay in indent mode
        { key = "<"; mode = "v"; action = "<gv"; opts = { noremap = true; silent = true; desc = "Stay in indent mode"; }; }
        { key = ">"; mode = "v"; action = ">gv"; opts = { noremap = true; silent = true; desc = "Stay in indent mode"; }; }
        
        # Cancel search highlighting
        { key = "<ESC>"; mode = "n"; action = ":nohlsearch<Bar>:echo<CR>"; opts = { noremap = true; silent = true; }; }
        
        # Jumplist
        { key = "<C-m>"; mode = "n"; action = "<C-i>"; opts = { noremap = true; silent = true; }; }
        
        # Diagnostic navigation
        { key = "gk"; mode = "n"; action = "vim.diagnostic.jump({count= -1,float = true})"; opts = { noremap = true; silent = true; desc = "Previous Diagnostic"; }; }
        { key = "gj"; mode = "n"; action = "vim.diagnostic.jump({count= 1,float = true})"; opts = { noremap = true; silent = true; desc = "Next Diagnostic"; }; }
      ];
    };

    # ═══════════════════════════════════════════════════════════════════════════
    # CUSTOM PLUGINS (that need additional config via Lua)
    # ═══════════════════════════════════════════════════════════════════════════
    # Additional plugins not covered by nvf modules
    startPlugins = [
      # Completion
      "saghen/blink.cmp"
      "rafamadriz/friendly-snippets"
      
      # Lazydev for Nix/Lua
      "folke/lazydev.nvim"
      
      # UI
      "nvim-tree/nvim-web-devicons"
      "stevearc/oil.nvim"
      "nvim-tree/nvim-tree.lua"
      
      # Terminal
      "akinsho/nvim-toggleterm.lua"
      
      # Git
      "NeogitOrg/neogit"
      "sindrets/diffview.nvim"
      "tanruinigr/hlargs.nvim"
      
      # Motion/Editing
      "echasnovski/mini.surround"
      "echasnovski/mini.comment"
      "echasnovski/mini.diff"
      "ThePrimeagen/harpoon"
      "folke/lazy.nvim"
      
      # Search
      "nvim-telescope/telescope.nvim"
      
      # Treesitter extras
      "nvim-treesitter/nvim-treesitter-context"
      
      # Utilities
      "stevearc/overseer.nvim"
      "folke/noice.nvim"
      "folke/which-key.nvim"
    ];

    # ═══════════════════════════════════════════════════════════════════════════
    # EXTRA LUA CONFIG FILES
    # ═══════════════════════════════════════════════════════════════════════════
    extraLuaFiles = {
      blink-cmp = ./nvf-lua/blink-cmp.lua;
    };

    # ═══════════════════════════════════════════════════════════════════════════
    # EXTRA PACKAGES (from existing neovim.nix)
    # ═══════════════════════════════════════════════════════════════════════════
    extraPackages = with pkgs; [
      lua-language-server
      python311Packages.python-lsp-server
      nixd
      nodePackages.biojs
      nodePackages.typescript-language-server
      nodePackages.json-languageserver
      nodePackages.vscode-langservers-extracted
      nodePackages.tailwindcss-language-server
      rust-analyzer
      gopls
      clang-tools
      nodePackages.prettier
      nodePackages.biome
      ruff
      go
      deadnix
      statix
      nil
    ];
  };
}
