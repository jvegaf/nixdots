-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local augroup = vim.api.nvim_create_augroup
local autocmds = vim.api.nvim_create_autocmd
augroup('discontinue_comments', { clear = true })
autocmds({ 'FileType' }, {
  pattern = { '*' },
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - 'o'
  end,
  group = 'discontinue_comments',
  desc = "Dont't continue comments with o/O",
})

autocmds({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.qss',
  command = 'set filetype=css',
})

autocmds({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.tpl',
  command = 'set filetype=html',
})
-- autocmds("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp_attach_auto_diag", { clear = true }),
--   callback = function(args)
--     -- the buffer where the lsp attached
--     ---@type number
--     local buffer = args.buf
--
--     -- create the autocmd to show diagnostics
--     vim.api.nvim_create_autocmd("CursorHold", {
--       group = vim.api.nvim_create_augroup("_auto_diag", { clear = true }),
--       buffer = buffer,
--       callback = function()
--         local opts = {
--           focusable = false,
--           close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--           border = "rounded",
--           source = "always",
--           prefix = " ",
--           scope = "cursor",
--         }
--         vim.diagnostic.open_float(nil, opts)
--       end,
--     })
--   end,
-- })
-- Turn off paste mode when leaving insert

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'make',
  command = 'setlocal noexpandtab',
})

autocmds('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- Avalonia XAML LSP
-- install lsp-servers: yay -S avalonia-ls-git

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.axaml' },
  callback = function(event)
    vim.lsp.start({
      name = 'avalonia',
      cmd = { 'avalonia-ls' },
      root_dir = vim.fn.getcwd(),
    })
  end,
})
vim.filetype.add({
  extension = {
    axaml = 'xml',
  },
})
-- set filetype xml for extension .axaml

-- Listen for `opencode` events
vim.api.nvim_create_autocmd('User', {
  pattern = 'OpencodeEvent',
  callback = function(args)
    -- See the available event types and their properties
    vim.notify(vim.inspect(args.data))
    -- Do something useful
    if args.data.type == 'session.idle' then
      vim.notify('`opencode` finished responding')
    end
  end,
})
