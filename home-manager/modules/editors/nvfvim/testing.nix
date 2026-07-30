{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pythonWithPytest = pkgs.python3.withPackages (pythonPackages: [ pythonPackages.pytest ]);
in
{
  programs.nvf.settings.vim = {
    startPlugins = [
      pkgs.vimPlugins.nvim-nio
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.neotest-python
    ];

    luaConfigRC.neotest =
      inputs.nvf.lib.nvim.dag.entryAfter
        [
          "pluginConfigs"
          "nvim-dap"
          "neotest-adapter-aliases"
        ]
        ''
          -- Neotest checks nvim-nio with pcall(), which the lazy module loader
          -- cannot see. Load it explicitly before Neotest starts.
          local nio = require("nio")
          local neotest = require("neotest")

          neotest.setup({
            adapters = {
              require("neotest-python")({
                dap = { justMyCode = false },
                runner = "pytest",
                python = function(root)
                  local candidates = {
                    root .. "/.venv/bin/python",
                    root .. "/venv/bin/python",
                  }
                  if vim.env.VIRTUAL_ENV then
                    table.insert(candidates, 1, vim.env.VIRTUAL_ENV .. "/bin/python")
                  end
                  for _, candidate in ipairs(candidates) do
                    if candidate and vim.fn.executable(candidate) == 1 then
                      return candidate
                    end
                  end
                  return "${lib.getExe pythonWithPytest}"
                end,
              }),
            },
            summary = {
              mappings = {
                -- A tree behaves like every other tree: h/l close/open,
                -- j/k move, Enter jumps to the selected test.
                expand = "l",
                parent = "h",
                jumpto = "<CR>",
              },
            },
            consumers = {
              luix_run_all = function(client)
                return {
                  run = nio.create(function()
                    local adapters = client:get_adapters()

                    if #adapters == 0 then
                      require("neotest.lib").notify(
                        "No test adapter found for this project",
                        vim.log.levels.WARN
                      )
                      return
                    end

                    table.sort(adapters)
                    local adapter = require("nio").ui.select(adapters, {
                      prompt = "Test adapter:",
                    })

                    if adapter then
                      neotest.run.run({ suite = true, adapter = adapter })
                    end
                  end),
                }
              end,
            },
          })

          local test_windows = vim.api.nvim_create_augroup("LuixNeotestWindows", { clear = true })
          vim.api.nvim_create_autocmd("FileType", {
            group = test_windows,
            pattern = { "neotest-summary", "neotest-output", "neotest-output-panel" },
            callback = function(args)
              local function close_test_window()
                local filetype = vim.bo[args.buf].filetype
                if filetype == "neotest-summary" then
                  neotest.summary.close()
                elseif filetype == "neotest-output-panel" then
                  neotest.output_panel.close()
                else
                  pcall(vim.api.nvim_win_close, 0, true)
                end
              end

              vim.keymap.set("n", "q", close_test_window, {
                buffer = args.buf,
                desc = "Close test window",
                silent = true,
              })
              vim.keymap.set("n", "<Esc>", close_test_window, {
                buffer = args.buf,
                desc = "Close test window",
                silent = true,
              })
            end,
          })
        '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>lua require('neotest').run.run()<CR>";
        desc = "Test nearest";
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>";
        desc = "Test current file";
      }
      {
        mode = "n";
        key = "<leader>ta";
        action = "<cmd>lua require('neotest').luix_run_all.run()<CR>";
        desc = "Test all with chosen adapter";
      }
      {
        mode = "n";
        key = "<leader>td";
        action = "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<CR>";
        desc = "Debug nearest test";
      }
      {
        mode = "n";
        key = "<leader>tr";
        action = "<cmd>lua require('neotest').run.run_last()<CR>";
        desc = "Repeat last test";
      }
      {
        mode = "n";
        key = "<leader>to";
        action = "<cmd>lua require('neotest').output.open({ enter = true })<CR>";
        desc = "Test output";
      }
      {
        mode = "n";
        key = "<leader>ts";
        action = ''
          function()
            local summary_buffer = vim.fn.bufnr("Neotest Summary")
            local summary_window = summary_buffer >= 0 and vim.fn.bufwinid(summary_buffer) or -1
            if summary_window ~= -1 then
              vim.api.nvim_set_current_win(summary_window)
            else
              require("neotest").summary.open({ enter = true })
            end
          end
        '';
        lua = true;
        desc = "Open or focus test summary";
      }
      {
        mode = "n";
        key = "<leader>tx";
        action = "<cmd>lua require('neotest').run.stop()<CR>";
        desc = "Stop test";
      }
    ];
  };
}
