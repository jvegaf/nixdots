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
        installDependencies = true;
        installRuntimeDependencies = true;
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
      ai.sidekick.enable = true;
      coding = {
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

    plugins.blink = ''
      return {
        "saghen/blink.cmp",
        opts = {
          keymap = {
            preset = "super-tab",
          },
        },
      }
    '';

    plugins.snacks = ''
      return {
        "snacks.nvim",
        opts = {
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

    # Additional packages (optional)
    # extraPackages = with pkgs; [
    #   nixd # Nix LSP
    #   alejandra # Nix formatter
    # ];
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
