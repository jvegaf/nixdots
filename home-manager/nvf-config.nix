{pkgs, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        extraPlugins = {
          statuscol-nvim = {
            package = pkgs.vimPlugins.statuscol-nvim;
          };
        };

        luaConfigPost = ''
          local builtin = require("statuscol.builtin")

          require("statuscol").setup({
            relculright = true,
            segments = {
              {
                sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
                click = "v:lua.ScSa",
              },
              { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              {
                sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
                click = "v:lua.ScSa",
              },
            },
          })
        '';

        # vim.opts and vim.options are aliased
        opts = {
          clipboard = "unnamedplus";
          cmdheight = 2;
          expandtab = true;
          foldcolumn = "1";
          foldlevel = 99;
          foldlevelstart = 99;
          shiftwidth = 2;
          smartcase = true;
          smartindent = true;
          tabstop = 2;
          title = true;
          undofile = true;
          wrap = false;
        };

        keymaps = [
          {
            key = "jk";
            action = "<ESC>";
            mode = "i";
            silent = true;
          }
          {
            key = "<leader>q";
            action = ":q!<CR>";
            mode = "n";
            silent = true;
          }
          {
            key = "W";
            action = ":w<CR>";
            mode = "n";
            silent = true;
          }
          {
            key = "Q";
            action = ":bdelete<CR>";
            mode = "n";
            silent = true;
          }
          {
            key = "vv";
            action = "V";
            mode = "n";
            silent = true;
          }
          {
            key = "<ESC>";
            action = ":nohlsearch<Bar>:echo<CR>";
            mode = "n";
            silent = true;
          }
          {
            key = "<C-a>";
            action = "gg<S-v>G";
            mode = "n";
            silent = true;
          }
          {
            key = "zR";
            action = "<cmd>lua require('ufo').openAllFolds()<CR>";
            mode = "n";
            silent = true;
          }
          {
            key = "zM";
            action = "<cmd>lua require('ufo').closeAllFolds()<CR>";
            mode = "n";
            silent = true;
          }
          {
            key = "<leader>e";
            action = ":Neotree focus<CR>";
            mode = "n";
            silent = true;
            desc = "Neotree";
          }
          # alejandra: off
        ];

        spellcheck = {
          enable = false;
          # programmingWordlist.enable = true;
        };

        lsp = {
          # This must be enabled for the language modules to hook into
          # the LSP API.
          enable = true;

          formatOnSave = false;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = false; # conflicts with blink in maximal
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
          harper-ls.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        # This section does not include a comprehensive list of available language modules.
        # To list all available language module options, please visit the nvf manual.
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          # Languages that will be supported in default and maximal configurations.
          nix.enable = true;
          markdown.enable = true;

          # Languages that are enabled in the maximal configuration.
          bash.enable = true;
          clang.enable = true;
          # cmake.enable = true;
          css.enable = true;
          html.enable = true;
          json.enable = true;
          sql.enable = true;
          java.enable = true;
          # kotlin.enable = true;
          ts.enable = true;
          # go.enable = true;
          lua.enable = true;
          # zig.enable = true;
          python.enable = true;
          # typst.enable = true;
          # rust = {
          #   enable = true;
          #   extensions.crates-nvim.enable = true;
          # };
          toml.enable = true;
          xml.enable = true;
          # tex.enable = true;

          # Language modules that are not as common.
          openscad.enable = false;
          arduino.enable = false;
          assembly.enable = false;
          astro.enable = false;
          nu.enable = false;
          csharp.enable = false;
          julia.enable = false;
          vala.enable = false;
          scala.enable = false;
          r.enable = false;
          gleam.enable = false;
          glsl.enable = false;
          dart.enable = false;
          ocaml.enable = false;
          elixir.enable = false;
          haskell.enable = false;
          hcl.enable = false;
          ruby.enable = false;
          fsharp.enable = false;
          just.enable = false;
          make.enable = false;
          qml.enable = false;
          jinja.enable = false;
          tailwind.enable = false;
          svelte.enable = false;
          liquid.enable = false;
          tera.enable = false;
          twig.enable = false;
          gettext.enable = false;
          fluent.enable = false;
          jq.enable = false;

          # Nim LSP is broken on Darwin and therefore
          # should be disabled by default. Users may still enable
          # `vim.languages.vim` to enable it, this does not restrict
          # that.
          # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
          nim.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          blink-indent.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "onedark";
          };
        };

        theme = {
          enable = true;
          name = "onedark";
          style = "dark";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete = {
          nvim-cmp.enable = false;
          blink-cmp.enable = true;
        };

        snippets.luasnip.enable = true;

        # filetree.nvimTree = {
        #   enable = true;
        #   openOnSetup = true;
        #
        #   mappings = {
        #     focus = "<leader>e";
        #     toggle = null;
        #     findFile = null;
        #     refresh = null;
        #   };
        #
        #   setupOpts = {
        #     diagnostics = {
        #       enable = true;
        #       icons = {
        #         hint = "";
        #         info = "";
        #         warning = "";
        #         error = "";
        #       };
        #     };
        #
        #     renderer = {
        #       group_empty = true;
        #       highlight_git = true;
        #       root_folder_modifier = ":~";
        #       icons.glyphs.git = {
        #         unstaged = "";
        #         staged = "";
        #         unmerged = "";
        #         renamed = "➜";
        #         untracked = "";
        #         deleted = "";
        #         ignored = "◌";
        #       };
        #     };
        #
        #     hijack_cursor = true;
        #
        #     update_focused_file = {
        #       enable = true;
        #       update_root = true;
        #     };
        #
        #     modified.enable = true;
        #
        #     git.timeout = 500;
        #
        #     actions.open_file = {
        #       quit_on_open = true;
        #       resize_window = false;
        #       window_picker.enable = true;
        #     };
        #
        #     view = {
        #       width = 40;
        #       side = "left";
        #       relativenumber = true;
        #     };
        #
        #     tab.sync = {
        #       open = true;
        #       close = true;
        #       ignore = [];
        #     };
        #   };
        # };

        filetree.neo-tree.enable = true;

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;
        telescope.setupOpts.pickers.colorscheme.enable_preview = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
          neogit.enable = false;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false; # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;
          qmk-nvim.enable = false; # requires hardware specific options
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = false;
          multicursors.enable = true;
          smart-splits.enable = true;
          undotree.enable = true;
          nvim-biscuits.enable = false;
          grug-far-nvim.enable = true;

          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };
          images = {
            image-nvim.enable = false;
            img-clip.enable = false;
          };
        };

        notes = {
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          nvim-ufo.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = [
                "90"
                "130"
              ];
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = false;
            cmp.enable = false;
          };
          codecompanion-nvim.enable = false;
          avante-nvim.enable = false;
        };

        session = {
          nvim-session-manager.enable = true;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };
      };
    };
  };
}
