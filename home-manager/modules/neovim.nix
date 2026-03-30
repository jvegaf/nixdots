{ lib, pkgs, ... }: {
  # AIDEV-NOTE: Migrated from neovim-config (LazyVim) to nvf - 2026-03-25
  programs.nvf = {
    enable = true;

    # Neovim package

    settings = {
      vim.package = pkgs.neovim-unwrapped;
      vim.opts.cmdheight = 2;
      vim.opts.shiftwidth = 2;
      vim.opts.mapleader = " ";
      vim.opts.maplocalleader = ",";
      vim.opts.smartindent = true;
      vim.opts.relativenumber = true;
      vim.opts.number = true;

      # ═══════════════════════════════════════════════════════════════════════════
      # BASIC VIM OPTIONS (migrated from lua/config/options.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      # vim = {
      #   # Leader keys
      #   mapleader = " ";
      #   maplocalleader = ",";
      #
      #   # Editing options
      #   # clipboard = "unnamedplus";
      #   expandtab = true;
      #   shiftwidth = 2;
      #   tabstop = 2;
      #   smartindent = true;
      #
      #   # UI options
      #   # cmdheight = 2;
      #   cursorline = true;
      #   number = true;
      #   relativenumber = true;
      #   numberwidth = 4;
      #   signcolumn = "yes";
      #   foldcolumn = "1";
      #   foldenable = true;
      #   foldlevel = 10;
      #   foldlevelstart = 99;
      #   laststatus = 3;
      #   showtabline = 2;
      #   showmode = true;
      #   pumheight = 15;
      #
      #   # Search options
      #   hlsearch = true;
      #   ignorecase = true;
      #   smartcase = true;
      #   incsearch = true;
      #
      #   # Terminal options
      #   shell = "zsh";
      #   termguicolors = true;
      #
      #   # Misc options
      #   mouse = "a";
      #   title = true;
      #   undofile = true;
      #   updatetime = 300;
      #   timeoutlen = 500;
      #   # backup = false;
      #   # writebackup = false;
      #   swapfile = false;
      #   splitbelow = true;
      #   splitright = true;
      #   wrap = false;
      #   completeopt = [ "menuone" "noselect" ];
      #   sidescrolloff = 8;
      #   ruler = true;
      #   showcmd = true;
      #   conceallevel = 0;
      #   encoding = "utf-8";
      #   fileencoding = "utf-8";
      #
      #   # Winbar
      #   winbar = "%=%m %f";
      #
      #   # Filetype
      #   filetype = {
      #     plugin = true;
      #     indent = true;
      #   };
      # };

      # ═══════════════════════════════════════════════════════════════════════════
      # COLORSCHEME - ayu (from lua/plugins/colorscheme.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      # colorscheme = "ayu";

      # ═══════════════════════════════════════════════════════════════════════════
      # LSP SUPPORT (from lua/plugins/lspconfig.lua + lazyvim extras)
      # ═══════════════════════════════════════════════════════════════════════════
      vim.lsp = {
        enable = true;
        formatOnSave = true;
      };

      # Language servers and tools
      vim.languages = {
        # TypeScript/JavaScript
        ts = {
          enable = true;
          # lsp = true;
          # format = {
          #   type = "biome";
          # };
        };
        
        # JSON
        json = {
	  enable = true;
          # lsp = true;
        };
        
        # HTML
        html = {
          enable = true;
        };
        
        # CSS
        css = {
          enable = true;
          # format = {
          #   type = "biome";
          # };
        };
        
        # Markdown
        markdown = {
          enable = true;
          # treesitter = true;
          # lsp = true;
        };
        
        # TOML
        toml = {
	  enable = true;
          # lsp = true;
          # format = true;
        };
        
        # Docker
        # docker = {
        #   enable = true;
        #   # lsp = true;
        # };
        
        # Git
        # git = {
        #   enable = true;
        # };
        
        # Python
        python = {
          enable = true;
          # lsp = {
          #   enable = true;
          # };
          # format = {
          #   type = "ruff";
          # };
        };
        
        # C/C++
        # clangd = {
        #   enable = true;
        #   lsp = {
        #     package = "clangd";
        #   };
        # };
        
        # Nix
        nix = {
          enable = true;
          # lsp = {
          #   enable = true;
          # };
          # format = {
          #   type = "nixfmt";
          # };
        };
        
        # Rust
        rust = {
          enable = true;
          # lsp = {
          #   enable = true;
          # };
        };
        
        # Go
        # go = {
          # enable = true;
          # lsp = {
          #   enable = true;
          # };
        # };
        
        # Lua
        lua = {
          enable = true;
          # lsp = {
          #   enable = true;
          # };
        };
        
        # YAML
        yaml = {
          enable = true;
          # lsp = true;
        };
        
        # Tailwind CSS
        # tailwindcss = {
        #   enable = true;
        # };
        
        # Clang (C/C++)
        # c = {
        #   enable = true;
        #   # lsp = {
        #   #   package = "clangd";
        #   # };
        # };
        
        # C++
        # cpp = {
        #   enable = true;
        #   # lsp = {
        #   #   package = "clangd";
        #   # };
        # };
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # TREESITTER (from lua/plugins/treesitter.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      vim.treesitter = {
        enable = true;
	context.enable = true;
	fold = true;
	textobjects.enable = true;
	autotagHtml = true;
        # ensureInstalled = [
        #   "tsx"
        #   "typescript"
        #   "java"
        #   "xml"
        #   "yaml"
        #   "html"
        #   "css"
        #   "json"
        #   "lua"
        #   "markdown"
        #   "markdown_inline"
        #   "bash"
        #   "python"
        #   "rust"
        #   "go"
        #   "c"
        #   "cpp"
        #   "nix"
        #   "dockerfile"
        #   "vim"
        #   "vimdoc"
        # ];
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # COMPLETION - blink.cmp
      # ═══════════════════════════════════════════════════════════════════════════
      vim.autocomplete.blink-cmp.enable = true;

      # ═══════════════════════════════════════════════════════════════════════════
      # DAP - Debug Adapter Protocol (from lazyvim extras)
      # ═══════════════════════════════════════════════════════════════════════════
      # dap = {
      #   enable = true;
      # };

      # ═══════════════════════════════════════════════════════════════════════════
      # UI PLUGINS
      # ═══════════════════════════════════════════════════════════════════════════
      # ui = {
      #   # Statusline
      #   statusline = {
      #     enable = true;
      #   };
      #
      #   # Icons
      #   icons = {
      #     enable = true;
      #   };
      # };

      # ═══════════════════════════════════════════════════════════════════════════
      # TERMINAL - toggleterm (from lua/plugins/toggleterm.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      vim.terminal = {
        toggleterm = {
          enable = true;
        };
      };

      # ═══════════════════════════════════════════════════════════════════════════
      # KEYMAPS (from lua/config/keymaps.lua)
      # ═══════════════════════════════════════════════════════════════════════════
      vim.keymaps = [
        # Exit insert mode
        { key = "jk"; mode = "i"; action = "<ESC>";  }
        
        # Save and quit
        { key = "<leader>wq"; mode = "n"; action = ":wq<CR>";  }
        { key = "<leader>q"; mode = "n"; action = ":q!<CR>";  }
        
        # Save
        { key = "W"; mode = "n"; action = ":w<CR>";  }
        
        # Close buffer
        { key = "Q"; mode = "n"; action = ":bdelete<CR>";  }
        
        # Buffer navigation
        { key = "H"; mode = "n"; action = ":BufferLineCyclePrev<cr>";  }
        { key = "L"; mode = "n"; action = ":BufferLineCycleNext<cr>";  }
        
        # Visual paste (don't yank)
        { key = "p"; mode = "v"; action = "\"_dP";  }
        
        # Select all
        # { key = "<C-a>"; mode = "n"; action = "gg<S-v>G";  }
        
        # Stay in indent mode
        { key = "<"; mode = "v"; action = "<gv";  }
        { key = ">"; mode = "v"; action = ">gv";  }
        
        # Cancel search highlighting
        { key = "<ESC>"; mode = "n"; action = ":nohlsearch<Bar>:echo<CR>";  }
        
        # Jumplist
        { key = "<C-m>"; mode = "n"; action = "<C-i>";  }
        
        # Diagnostic navigation
        { key = "gk"; mode = "n"; action = "vim.diagnostic.jump({count= -1,float = true})"; }
        { key = "gj"; mode = "n"; action = "vim.diagnostic.jump({count= 1,float = true})";  }
      ];
    };

    # ═══════════════════════════════════════════════════════════════════════════
    # CUSTOM PLUGINS (that need additional config via Lua)
    # ═══════════════════════════════════════════════════════════════════════════
    # Additional plugins not covered by nvf modules
    # settings.vim.startPlugins = [
    #   # Completion
    #   "blink-cmp"
    #   "friendly-snippets"
    #
    #   # Lazydev for Nix/Lua
    #   "lazydev-nvim"
    #
    #   # UI
    #   "nvim-web-devicons"
    #   "oil-nvim"
    #   "nvim-tree-lua"
    #
    #   # Terminal
    #   "toggleterm-nvim"
    #
    #   # Git
    #   "neogit"
    #   "diffview-nvim"
    #   "hlargs-nvim"
    #
    #   # Motion/Editing
    #   "mini-surround"
    #   "mini-comment"
    #   "mini-diff"
    #   "harpoon"
    #
    #   # Search
    #   "telescope"
    #
    #   # Utilities
    #   "onedark"
    # ];

    # ═══════════════════════════════════════════════════════════════════════════
    # EXTRA LUA CONFIG FILES
    # ═══════════════════════════════════════════════════════════════════════════
    # extraLuaFiles = {
    #   blink-cmp = ./nvf-lua/blink-cmp.lua;
    # };

    # ═══════════════════════════════════════════════════════════════════════════
    # EXTRA PACKAGES (from existing neovim.nix)
    # ═══════════════════════════════════════════════════════════════════════════
    # vim.extraPackages = with pkgs; [
    #   lua-language-server
    #   python311Packages.python-lsp-server
    #   nixd
    #   nodePackages.typescript-language-server
    #   vscode-json-languageserver
    #   nodePackages.vscode-langservers-extracted
    #   tailwindcss-language-server
    #   rust-analyzer
    #   gopls
    #   clang-tools
    #   prettier
    #   biome
    #   ruff
    #   go
    #   deadnix
    #   statix
    #   nil
    # ];
  };
}
