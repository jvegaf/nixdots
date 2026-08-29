{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;

    pluginSource = "nixpkgs";

    installCoreDependencies = true;

    extras = {
      lang.nix = {
        enable = true;
      };
      lang.python = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
      lang.rust = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
      lang.toml = {
        enable = true;
        installDependencies = true;
      };
      lang.yaml = {
        enable = true;
        installDependencies = true;
      };
      ai.sidekick.enable = true;
      coding = {
        blink.enable = true;
        luasnip.enable = true;
        mini-comment.enable = true;
        mini-surround.enable = true;
        mini-snippets.enable = true;
        yanky.enable = true;
      };
      editor = {
        dial.enable = true;
        harpoon2.enable = true;
        illuminate.enable = true;
        inc-rename.enable = true;
        mini-diff.enable = true;
        outline.enable = true;
        refactoring.enable = true;
        telescope.enable = true;
        snacks-picker.enable = true;
      };
      ui = {
        indent-blankline.enable = true;
        smear-cursor.enable = true;
      };

    };

    plugins.lazygit = ''
      return {
          "kdheepak/lazygit.nvim",
          lazy = true,
          cmd = {
              "LazyGit",
              "LazyGitConfig",
              "LazyGitCurrentFile",
              "LazyGitFilter",
              "LazyGitFilterCurrentFile",
          },
          -- optional for floating window border decoration
          dependencies = {
              "nvim-lua/plenary.nvim",
          },
          -- setting the keybinding for LazyGit with 'keys' is recommended in
          -- order to load the plugin when the command is run for the first time
          keys = {
              { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
          }
      }
    '';

    plugins.easy-align = ''
      return {
        "nvim-mini/mini.align",
        version = "*",
        opts = {
          mappings = {
            start = "ga",
            start_with_preview = "ga",
            -- these are advanced mappings that can be used to control
            -- alignment more precisely (see `:h mini.align.setup` for details).
            -- for basic usage, you can remove them.
            start_line = "gi",
            start_line_with_preview = "gi",
            align_to_char = "gm",
            align_to_char_with_preview = "gm",
          },
        },
      }
    '';

    plugins.blink = ''
      return {
        "saghen/blink.cmp",
        opts = {
          keymap = {
            preset = "enter",
          },
          completion = {
            menu = {
              border = "rounded",
              direction_priority = { "n", "s" },
              draw = {
                columns = {
                  { "label", "label_description", gap = 1 },
                  { "kind_icon", "kind" },
                },
              },
            },
          },
        },
      }
    '';

    plugins.snacks = ''
      return {
        "snacks.nvim",
        opts = {
          picker = {
            sources = {
              explorer = {
                focus = "input",
                auto_close = true,
              },
            },
          },
          dashboard = {
            preset = {
              pick = function(cmd, opts)
                return LazyVim.pick(cmd, opts)()
              end,
              header = [[
              ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
              ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
              ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
              ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
              ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
              ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
       ]],
              -- stylua: ignore
              ---@type snacks.dashboard.Item[]
              keys = {
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                -- { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
                -- { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
              },
            },
          },
        },
      }
    '';

    plugins.url-open = ''
      return {
        "sontungexpt/url-open",
        cmd = "URLOpenUnderCursor",
        config = function()
          local status_ok, url_open = pcall(require, "url-open")
          if not status_ok then
            return
          end
          url_open.setup({})

          vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>")
        end,
      }
    '';

    plugins.treesj = ''
      return {
        "Wansmer/treesj",
        keys = { { "<leader>j", "<CMD>TSJToggle<CR>", desc = "Toggle Split Join" } },
        cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
        opts = {
          use_default_keymaps = false,
          max_join_length = 200,
        },
      }
    '';

    plugins.codediff = ''
      return {
          "esmuellert/codediff.nvim",
          cmd = "CodeDiff",
          keys = {
            { "<leader>gd", "<cmd>CodeDiff HEAD<cr>", desc = "Open diff from last commit" },
            { "<leader>gf", "<cmd>CodeDiff history<cr>", desc = "View file history" },
            { "<leader>gf", ":\"<,\">CodeDiff history<cr>", mode = { "v" }, desc = "View selected history" },
          },
        }
    '';

    plugins.browser-search = ''
      return {
        "jvegaf/browse.nvim",
        dependencies = {
          "nvim-telescope/telescope.nvim",
        },
        keys = {
          { "<leader>ff", "<cmd>VisualSearch<cr>", mode = "v", desc = "Search on web" },
          { "<leader>fb", "<cmd>VisualBookmarks<cr>", mode = "v", desc = "Search on web bookmarks" },
          { "<leader>si", "<cmd>InputSearch<cr>", desc = "Search on web" },
        },
        config = function()
          -- code
          local bookmarks = {
            ["github"] = {
              ["name"] = "search github from neovim",
              ["code_search"] = "https://github.com/search?q=%s&type=code",
              ["repo_search"] = "https://github.com/search?q=%s&type=repositories",
              ["issues_search"] = "https://github.com/search?q=%s&type=issues",
              ["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
            },
            ["npm"] = "https://www.npmjs.com/search?q=%s",
            ["pipy"] = "https://pypi.org/search/?q=%s",
            ["stackoverflow"] = "https://stackoverflow.com/search?q=%s",
            ["youtube"] = "https://www.youtube.com/results?search_query=%s&page=&utm_source=opensearch",
          }

          local browse = require("browse")

          local function command(name, rhs, opts)
            opts = opts or {}
            vim.api.nvim_create_user_command(name, rhs, opts)
          end

          command("InputSearch", function()
            browse.input_search()
          end, {})

          command("VisualSearch", function(input)
            browse.input_search(input)
          end, {})

          -- this will open telescope using dropdown theme with all the available options
          -- in which `browse.nvim` can be used
          command("Browse", function()
            browse.browse({ bookmarks = bookmarks })
          end)

          command("Bookmarks", function()
            browse.open_bookmarks({ bookmarks = bookmarks })
          end)

          command("VisualBookmarks", function(input)
            browse.open_bookmarks({ bookmarks = bookmarks, visual_text = input })
          end)

          command("DevdocsSearch", function()
            browse.devdocs.search()
          end)

          command("DevdocsFiletypeSearch", function()
            browse.devdocs.search_with_filetype()
          end)

          command("MdnSearch", function()
            browse.mdn.search()
          end)
        end,
      }
    '';

    plugins.tmux = ''
      return {
        "christoomey/vim-tmux-navigator",
        cmd = {
          "TmuxNavigateLeft",
          "TmuxNavigateDown",
          "TmuxNavigateUp",
          "TmuxNavigateRight",
          "TmuxNavigatePrevious",
        },
        keys = {
          { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
          { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
          { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
          { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
          { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
        event = function()
          if vim.fn.exists("$TMUX") == 1 then
            return "VeryLazy"
          end
        end,
      }
    '';

    # Additional packages (optional)
    extraPackages = with pkgs; [
      # alejandra # Nix formatter
      bash-language-server
      lua-language-server
      nixd
      nixfmt
      jq
      isort
      ruff
      shfmt
      statix
      stylelint
      stylua
      typos-lsp
      vscode-langservers-extracted
      yamlfmt
      yaml-language-server
    ];
    # # IMPORTANT: Extras don't install treesitter parsers automatically
    # # You must add them manually for syntax highlighting
    # treesitterParsers = with pkgs.tree-sitter-grammars; [
    #   tree-sitter-nix
    #   tree-sitter-python
    # ];

    config = {
      options = ''
        vim.g.mapleader = " "
        vim.g.maplocalleader = ","
        vim.opt.relativenumber = true
        vim.opt.wrap = false
        vim.opt.swapfile = false
        vim.opt.undofile = true
        vim.opt.smartcase = true
        vim.opt.foldenable = true
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.LazyVim.treesitter.foldexpr()"
      '';

      keymaps = ''

        vim.keymap.set("i", "jk", "<ESC>")
        vim.keymap.set("n", "Q", ":q<CR>")
        vim.keymap.set("n", "W", ":w<CR>")
        vim.keymap.set("n", "<M-q>", ":bdelete<CR>")

         -- Buffers
        vim.keymap.set("n", "<M-,>", ":BufferLineCyclePrev<cr>")
        vim.keymap.set("n", "<M-.>", ":BufferLineCycleNext<cr>")
        vim.keymap.set("n", "<leader>bb", ":e #<cr>")

        -- Tab management
        vim.keymap.set("n", "<localleader>to", ":tabnew<CR>") -- open a new tab
        vim.keymap.set("n", "<localleader>tx", ":tabclose<CR>") -- close a tab
        vim.keymap.set("n", "<localleader>tn", ":tabn<CR>") -- next tab
        vim.keymap.set("n", "<localleader>tp", ":tabp<CR>") -- previous tab
        vim.keymap.set("n", "<localleader>,", ":tabNext<CR>")

        -- Quickfix keymaps
        vim.keymap.set("n", "<localleader>qo", ":copen<CR>") -- open quickfix list
        vim.keymap.set("n", "<localleader>qf", ":cfirst<CR>") -- jump to first quickfix list item
        vim.keymap.set("n", "<localleader>qn", ":cnext<CR>") -- jump to next quickfix list item
        vim.keymap.set("n", "<localleader>qp", ":cprev<CR>") -- jump to prev quickfix list item
        vim.keymap.set("n", "<localleader>ql", ":clast<CR>") -- jump to last quickfix list item
        vim.keymap.set("n", "<localleader>qc", ":cclose<CR>") -- close quickfix list

        -- LSP keymaps
        -- rename symbol
        vim.keymap.set("n", "<localleader>rl", "<cmd>lua vim.lsp.buf.rename()<CR>", NS)

        --diagnotic keymaps
        vim.keymap.set("n", "gk", function() vim.diagnostic.jump({count= -1,float = true}) end, { desc = "Previous Diagnostic" })
        vim.keymap.set("n", "gj", function() vim.diagnostic.jump({count= 1,float = true}) end, { desc = "Next Diagnostic" })

        vim.keymap.set("v", "p", '"_dP')

        vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>")

        vim.keymap.set("n", "<C-a>", "gg<S-v>G")

        vim.keymap.set("n", "vv", "V")

        vim.keymap.set("v", "<", "<gv", { desc = "Stay in indent mode" })
        vim.keymap.set("v", ">", ">gv", { desc = "Stay in indent mode" })

      '';

      autocmds = ''

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "make",
          command = "setlocal noexpandtab",
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
          pattern = "*",
          command = "set nopaste",
        })

        -- Listen for `opencode` events
        vim.api.nvim_create_autocmd("User", {
          pattern = "OpencodeEvent",
          callback = function(args)
            -- See the available event types and their properties
            vim.notify(vim.inspect(args.data))
            -- Do something useful
            if args.data.type == "session.idle" then
              vim.notify("`opencode` finished responding")
            end
          end,
        })
      '';
    };

  };

}
