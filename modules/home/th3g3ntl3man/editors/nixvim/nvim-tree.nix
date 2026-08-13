{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  plugins.nvim-tree = {
    enable = true;
    autoClose = true;
    luaConfig.pre = # lua
      ''
        local api = require('nvim-tree.api')
        api.events.subscribe(api.events.Event.FileCreated, function(file)
          vim.cmd('edit ' .. file.fname)
        end)

        local function my_on_attach(bufnr)
          local function edit_or_open()
            local node = api.tree.get_node_under_cursor()

            if node.nodes ~= nil then
              -- expand or collapse folder
              api.node.open.edit()
            else
              -- open file
              api.node.open.edit()
              -- Close the tree if file was opened
              api.tree.close()
            end
          end

          -- open as vsplit on current node
          local function vsplit_preview()
            local node = api.tree.get_node_under_cursor()

            if node.nodes ~= nil then
              -- expand or collapse folder
              api.node.open.edit()
            else
              -- open file as vsplit
              api.node.open.vertical()
            end

            -- Finally refocus on tree if it was lost
            api.tree.focus()
          end

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          api.config.mappings.default_on_attach(bufnr)

          vim.keymap.set('n', 'l', edit_or_open, opts('Edit Or Open'))
          vim.keymap.set('n', 'L', vsplit_preview, opts('Vsplit Preview'))
          vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Folder'))
          vim.keymap.set('n', 'H', api.node.navigate.parent, opts('Parent'))
        end
      '';
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>NvimTreeFocus<cr>";
      options = {
        desc = "Open NvimTree";
      };
    }
  ];
}
