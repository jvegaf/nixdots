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
      lang = {
        nix = {
          enable = true;
        };
        python = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        rust = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        toml = {
          enable = true;
          installDependencies = true;
        };
        yaml = {
          enable = true;
          installDependencies = true;
        };
      };
      ai.sidekick.enable = true;
      coding = {
        blink = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
          config = ''
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
        };
        # luasnip.enable = true;
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
        neo-tree = {
          enable = true;
          config = ''
            return {
              {
                "nvim-neo-tree/neo-tree.nvim",
                branch = "v3.x",
                dependencies = {
                  "nvim-lua/plenary.nvim",
                  "MunifTanjim/nui.nvim",
                  "nvim-tree/nvim-web-devicons",
                },
                opts = function()
                  vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
                  require("neo-tree").setup({
                    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
                    popup_border_style = "NC", -- or "" to use 'winborder' on Neovim v0.11+
                    clipboard = {
                      sync = "none", -- or "global"/"universal" to share a clipboard for each/all Neovim instance(s), respectively
                    },
                    enable_git_status = true,
                    enable_diagnostics = true,
                    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
                    open_files_using_relative_paths = false,
                    sort_case_insensitive = false, -- used when sorting files and directories in the tree
                    sort_function = nil, -- use a custom function for sorting files and directories in the tree
                    -- sort_function = function (a,b)
                    --       if a.type == b.type then
                    --           return a.path > b.path
                    --       else
                    --           return a.type > b.type
                    --       end
                    --   end , -- this sorts files and directories descendantly
                    default_component_configs = {
                      container = {
                        enable_character_fade = true,
                      },
                      indent = {
                        indent_size = 2,
                        padding = 1, -- extra padding on left hand side
                        -- indent guides
                        with_markers = true,
                        indent_marker = "│",
                        last_indent_marker = "└",
                        highlight = "NeoTreeIndentMarker",
                        -- expander config, needed for nesting files
                        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                      },
                      icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "󰜌",
                        provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
                          if node.type == "file" or node.type == "terminal" then
                            local success, web_devicons = pcall(require, "nvim-web-devicons")
                            local name = node.type == "terminal" and "terminal" or node.name
                            if success then
                              local devicon, hl = web_devicons.get_icon(name)
                              icon.text = devicon or icon.text
                              icon.highlight = hl or icon.highlight
                            end
                          end
                        end,
                        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                        -- then these will never be used.
                        default = "*",
                        highlight = "NeoTreeFileIcon",
                        use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
                      },
                      modified = {
                        symbol = "[+]",
                        highlight = "NeoTreeModified",
                      },
                      name = {
                        trailing_slash = false,
                        use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
                        use_git_status_colors = true,
                        highlight = "NeoTreeFileName",
                      },
                      git_status = {
                        symbols = {
                          -- Change type
                          added = "", -- or "✚"
                          modified = "", -- or ""
                          deleted = "✖", -- this can only be used in the git_status source
                          renamed = "󰁕", -- this can only be used in the git_status source
                          -- Status type
                          untracked = "",
                          ignored = "",
                          unstaged = "󰄱",
                          staged = "",
                          conflict = "",
                        },
                      },
                      -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                      file_size = {
                        enabled = true,
                        width = 12, -- width of the column
                        required_width = 64, -- min width of window required to show this column
                      },
                      type = {
                        enabled = true,
                        width = 10, -- width of the column
                        required_width = 122, -- min width of window required to show this column
                      },
                      last_modified = {
                        enabled = true,
                        width = 20, -- width of the column
                        required_width = 88, -- min width of window required to show this column
                      },
                      created = {
                        enabled = true,
                        width = 20, -- width of the column
                        required_width = 110, -- min width of window required to show this column
                      },
                      symlink_target = {
                        enabled = false,
                      },
                    },
                    -- A list of functions, each representing a global custom command
                    -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
                    -- see `:h neo-tree-custom-commands-global`
                    commands = {},
                    window = {
                      position = "left",
                      width = 40,
                      mapping_options = {
                        noremap = true,
                        nowait = true,
                      },
                      mappings = {
                        ["<C-s>"] = {
                          "quick_jump",
                          config = {
                            -- This will automaticly open / toggle the target node after jumping.
                            -- You can set it to `nil` to perform only the jump action,
                            -- or write your own callback (---@type fun(state, node)).
                            on_jump = "open_or_toggle",
                            jump_labels = "jfkdlsahgnuvrbytmiceoxwpqz",
                          }
                        },
                        ["<Tab>"] = "select",
                        ["<C-;>"] = "clear_selection",
                        ["<space>"] = {
                          "toggle_node",
                          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                        },
                        ["<2-LeftMouse>"] = "open",
                        ["<cr>"] = "open",
                        ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                        ["P"] = {
                          "toggle_preview",
                          config = {
                            use_float = true,
                            use_snacks_image = true,
                            use_image_nvim = true,
                          },
                        },
                        -- Read `# Preview Mode` for more information
                        ["l"] = "focus_preview",
                        ["S"] = "open_split",
                        ["s"] = "open_vsplit",
                        -- ["S"] = "split_with_window_picker",
                        -- ["s"] = "vsplit_with_window_picker",
                        ["t"] = "open_tabnew",
                        -- ["<cr>"] = "open_drop",
                        -- ["t"] = "open_tab_drop",
                        ["w"] = "open_with_window_picker",
                        --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                        ["C"] = "close_node",
                        -- ['C'] = 'close_all_subnodes',
                        ["z"] = "close_all_nodes",
                        --["Z"] = "expand_all_nodes",
                        --["Z"] = "expand_all_subnodes",
                        ["a"] = {
                          "add",
                          -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                          config = {
                            show_path = "none", -- "none", "relative", "absolute"
                          },
                        },
                        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                        ["d"] = "delete",
                        ["r"] = "rename",
                        ["b"] = "rename_basename",
                        ["y"] = "copy_to_clipboard",
                        ["x"] = "cut_to_clipboard",
                        ["p"] = "paste_from_clipboard",
                        ["<C-r>"] = "clear_clipboard",
                        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                        -- ["c"] = {
                        --  "copy",
                        --  config = {
                        --    show_path = "none" -- "none", "relative", "absolute"
                        --  }
                        --}
                        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                        ["q"] = "close_window",
                        ["R"] = "refresh",
                        ["?"] = "show_help",
                        ["<"] = "prev_source",
                        [">"] = "next_source",
                        ["i"] = "show_file_details",
                        -- ["i"] = {
                        --   "show_file_details",
                        --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
                        --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
                        --   -- config = {
                        --   --   created_format = "%Y-%m-%d %I:%M %p",
                        --   --   modified_format = "relative", -- equivalent to the line below
                        --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
                        --   -- }
                        -- },
                      },
                    },
                    nesting_rules = {},
                    filesystem = {
                      filtered_items = {
                        visible = false, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = true,
                        hide_gitignored = true,
                        hide_ignored = true, -- hide files that are ignored by other gitignore-like files
                        -- other gitignore-like files, in descending order of precedence.
                        ignore_files = {
                          ".neotreeignore",
                          ".ignore",
                          -- ".rgignore"
                        },
                        hide_hidden = true, -- only works on Windows for hidden files/directories
                        hide_by_name = {
                          --"node_modules"
                        },
                        hide_by_pattern = { -- uses glob style patterns
                          --"*.meta",
                          --"*/src/*/tsconfig.json",
                        },
                        always_show = { -- remains visible even if other settings would normally hide it
                          --".gitignored",
                        },
                        always_show_by_pattern = { -- uses glob style patterns
                          --".env*",
                        },
                        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                          --".DS_Store",
                          --"thumbs.db"
                        },
                        never_show_by_pattern = { -- uses glob style patterns
                          --".null-ls_*",
                        },
                      },
                      follow_current_file = {
                        enabled = false, -- This will find and focus the file in the active buffer every time
                        --               -- the current file is changed while the tree is open.
                        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                      },
                      group_empty_dirs = false, -- when true, empty folders will be grouped together
                      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                      -- in whatever position is specified in window.position
                      -- "open_current",  -- netrw disabled, opening a directory opens within the
                      -- window like netrw would, regardless of window.position
                      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                      use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                      -- instead of relying on nvim autocmd events.
                      window = {
                        mappings = {
                          ["<bs>"] = "navigate_up",
                          ["."] = "set_root",
                          ["H"] = "toggle_hidden",
                          ["/"] = "fuzzy_finder",
                          ["D"] = "fuzzy_finder_directory",
                          ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                          -- ["D"] = "fuzzy_sorter_directory",
                          ["f"] = "filter_on_submit",
                          ["<c-x>"] = "clear_filter",
                          ["[g"] = "prev_git_modified",
                          ["]g"] = "next_git_modified",
                          ["o"] = {
                            "show_help",
                            nowait = false,
                            config = { title = "Order by", prefix_key = "o" },
                          },
                          ["oc"] = { "order_by_created", nowait = false },
                          ["od"] = { "order_by_diagnostics", nowait = false },
                          ["og"] = { "order_by_git_status", nowait = false },
                          ["om"] = { "order_by_modified", nowait = false },
                          ["on"] = { "order_by_name", nowait = false },
                          ["os"] = { "order_by_size", nowait = false },
                          ["ot"] = { "order_by_type", nowait = false },
                          -- ['<key>'] = function(state) ... end,
                        },
                        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                          ["<down>"] = "move_cursor_down",
                          ["<C-n>"] = "move_cursor_down",
                          ["<up>"] = "move_cursor_up",
                          ["<C-p>"] = "move_cursor_up",
                          ["<esc>"] = "close",
                          ["<S-CR>"] = "close_keep_filter",
                          ["<C-CR>"] = "close_clear_filter",
                          ["<C-w>"] = { "<C-S-w>", raw = true },
                          {
                            -- normal mode mappings
                            n = {
                              ["j"] = "move_cursor_down",
                              ["k"] = "move_cursor_up",
                              ["<S-CR>"] = "close_keep_filter",
                              ["<C-CR>"] = "close_clear_filter",
                              ["<esc>"] = "close",
                            }
                          }
                          -- ["<esc>"] = "noop", -- if you want to use normal mode
                          -- ["key"] = function(state, scroll_padding) ... end,
                        },
                      },

                      commands = {}, -- Add a custom command or override a global one using the same function name
                    },
                    buffers = {
                      follow_current_file = {
                        enabled = true, -- This will find and focus the file in the active buffer every time
                        --              -- the current file is changed while the tree is open.
                        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                      },
                      group_empty_dirs = true, -- when true, empty folders will be grouped together
                      show_unloaded = true,
                      window = {
                        mappings = {
                          ["d"] = "buffer_delete",
                          ["bd"] = "buffer_delete",
                          ["<bs>"] = "navigate_up",
                          ["."] = "set_root",
                          ["o"] = {
                            "show_help",
                            nowait = false,
                            config = { title = "Order by", prefix_key = "o" },
                          },
                          ["oc"] = { "order_by_created", nowait = false },
                          ["od"] = { "order_by_diagnostics", nowait = false },
                          ["om"] = { "order_by_modified", nowait = false },
                          ["on"] = { "order_by_name", nowait = false },
                          ["os"] = { "order_by_size", nowait = false },
                          ["ot"] = { "order_by_type", nowait = false },
                        },
                      },
                    },
                    git_status = {
                      window = {
                        position = "float",
                        mappings = {
                          ["A"] = "git_add_all",
                          ["gu"] = "git_unstage_file",
                          ["gU"] = "git_undo_last_commit",
                          ["ga"] = "git_add_file",
                          ["gt"] = "git_toggle_file_stage",
                          ["gr"] = "git_revert_file",
                          ["gc"] = "git_commit",
                          ["gp"] = "git_push",
                          ["gl"] = "git_pull",
                          ["gg"] = "git_commit_and_push",
                          ["o"] = {
                            "show_help",
                            nowait = false,
                            config = { title = "Order by", prefix_key = "o" },
                          },
                          ["oc"] = { "order_by_created", nowait = false },
                          ["od"] = { "order_by_diagnostics", nowait = false },
                          ["om"] = { "order_by_modified", nowait = false },
                          ["on"] = { "order_by_name", nowait = false },
                          ["os"] = { "order_by_size", nowait = false },
                          ["ot"] = { "order_by_type", nowait = false },
                        },
                      },
                    },
                  })
                end,
              },
              {
                "Crysthamus/nvim-file-operations",
                -- branch = "compat" -- if you are on Neovim <= 0.10
                dependencies = {
                  "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
                },
                config = function()
                  require("nvim-file-operations").setup()
                end,
              },
              {
                "s1n7ax/nvim-window-picker",
                version = "2.*",
                config = function()
                  require("window-picker").setup({
                    filter_rules = {
                      include_current_win = false,
                      autoselect_one = true,
                      -- filter using buffer options
                      bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { "neo-tree", "neo-tree-popup", "notify" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { "terminal", "quickfix" },
                      },
                    },
                  })
                end,
              },
            }
          '';
        };
      };
      ui = {
        indent-blankline.enable = true;
        smear-cursor.enable = true;
      };

    };
    plugins = {
      lazygit = ''
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

      easy-align = ''
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

      snacks = ''
        return {
          "snacks.nvim",
          opts = {
            -- picker = {
            --   sources = {
            --     explorer = {
            --       focus = "input",
            --       auto_close = true,
            --     },
            --   },
            -- },
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

      url-open = ''
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

      treesj = ''
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

      codediff = ''
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

      browser-search = ''
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

      tmux = ''
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
    };

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
