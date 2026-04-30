# Neovim configuration managed using https://github.com/nix-community/nixvim
{
  # Theme
  colorschemes.tokyonight.enable = true;

  defaultEditor = true;

  # Settings
  opts = {
    backup = false;
    clipboard = "unnamedplus";
    cmdheight = 2;
    cursorline = true;
    expandtab = true;
    foldcolumn = "1";
    foldenable = true;
    foldlevel = 10;
    foldlevelstart = 99;
    hlsearch = true;
    ignorecase = true;
    incsearch = true;
    laststatus = 3;
    number = true;
    pumheight = 15;
    relativenumber = true;
    shiftwidth = 2;
    smartindent = true;
    showcmd = true;
    showmode = true;
    showtabline = 2;
    tabstop = 2;
    timeoutlen = 500;
    title = true;
    undofile = true;
    updatetime = 300;
    wrap = false;
    writebackup = false;
  };

  # Keymaps
  globals = {
    mapleader = " ";
    maplocalleader = ",";
  };

  keymaps = [
    {
      action = "<cmd>write<CR>";
      key = "W";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>bdelete<CR>";
      key = "q";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>quit!<CR>";
      key = "Q";
      options = {
        silent = true;
      };
    }
    {
      action = "V";
      key = "vv";
    }
    {
      action = "<cmd>BufferLineCyclePrev<cr>";
      key = "H";
    }
    {
      action = "<cmd>BufferLineCycleNext<cr>";
      key = "L";
    }
    {
      action = ":nohlsearch<Bar>:echo<CR>";
      key = "<ESC>";
    }
    {
      action = "gg<S-v>G";
      key = "<C-a>";
    }
    {
      action = "<C-i>";
      key = "<C-m>";
    }
    {
      action = "<gv";
      key = "<";
      mode = "v";
    }
    {
      action = ">gv";
      key = ">";
      mode = "v";
    }
    {
      action = "<ESC>";
      key = "jk";
      mode = "i";
    }
    {
      action = "<cmd>LazyGit<CR>";
      key = "<leader>gg";
    }
    {
      action = "<esc>:URLOpenUnderCursor<cr>";
      key = "gx";
    }
    {
      action = "<cmd>UrlView buffer<cr>";
      key = "<leader>bu";
    }
    {
      action = "<cmd>checkhealth<cr>";
      key = "<leader>zh";
    }
    {
      action = "<cmd>messages<cr>";
      key = "<leader>zm";
    }
    {
      action = "<cmd>UrlView lazy<cr>";
      key = "<leader>zu";
    }
    {
      action = "<cmd>NvimTreeFocus<cr>";
      key = "<leader>e";
    }
    {
      action = "<cmd>TSJToggle<cr>";
      key = "<leader>j";
    }

  ];

  plugins = {

    # UI
    web-devicons.enable = true;
    lualine.enable = true;
    bufferline.enable = true;
    treesitter.enable = true;
    which-key = {
      enable = true;
    };
    noice = {
      # WARNING: This is considered experimental feature, but provides nice UX
      enable = true;
      settings.presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        #inc_rename = false;
        #lsp_doc_border = false;
      };
    };
    telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = {
          options.desc = "file finder";
          action = "find_files";
        };
        "<leader>fg" = {
          options.desc = "find via grep";
          action = "live_grep";
        };
      };
      extensions = {
        file-browser.enable = true;
      };
    };

    nvim-tree = {
      enable = true;
      autoClose = true;
      openOnSetup = true;
      keymaps = {
        "<leader>e" = {
          options.desc = "file browser";
          action = "<cmd>NeovimTreeFocus<cr>";
        };
      };
    };

    tmux-navigator = {
      enable = true;
    };

    treesj = {
      enable = true;
      settings = {
        max_join_length = 200;
        use_default_keymaps = false;
      };
    };

    nvim-ufo.enable = true;

    # Dev
    lsp = {
      enable = true;
      servers = {
        hls = {
          enable = true;
          installGhc = false; # Managed by Nix devShell
        };
        marksman.enable = true;
        nil_ls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };
    };
    lazygit.enable = true;
  };

}
