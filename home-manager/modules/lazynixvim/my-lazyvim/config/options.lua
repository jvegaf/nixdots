local options = {
  backup = false, -- creates a backup file
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- highlight the current line
  encoding = 'utf-8',
  expandtab = true, -- convert tabs to spaces
  fileencoding = 'utf-8', -- the encoding written to a file
  foldcolumn = '1',
  foldenable = true,
  foldlevel = 10,
  foldlevelstart = 99,
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  incsearch = true,
  laststatus = 3,
  mouse = 'a', -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  pumheight = 15, -- pop up menu height
  relativenumber = true, -- set relative numbered lines
  ruler = true,
  shell = 'zsh',
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showcmd = true,
  showmode = true, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  sidescrolloff = 8,
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true,
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  winbar = '%=%m %f',
}

-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.fillchars = vim.opt.fillchars + 'eob: '
-- vim.opt.fillchars:append {
--   stl = ' ',
-- }

-- vim.opt.shortmess:append('c')

-- vim.opt.diffopt = { 'internal', 'filler', 'closeoff', 'hiddenoff', 'algorithm:minimal' }
--
-- vim.opt.backspace = { 'start', 'eol', 'indent' }
-- vim.opt.path:append({ '**' }) -- Finding files - Search down into subfolders
-- vim.opt.wildignore:append({ '*/node_modules/*' })

-- Undercurl
-- vim.cmd([[let &t_Cs = "\e[4:3m"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
-- vim.api.nvim_create_autocmd('InsertLeave', {
--   pattern = '*',
--   command = 'set nopaste',
-- })

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- -- TODO: w, {v, b, l}
-- vim.opt.formatoptions = vim.opt.formatoptions
--     - "a" -- Auto formatting is BAD.
--     - "t" -- Don't auto format my code. I got linters for that.
--     + "c" -- In general, I like it when comments respect textwidth
--     + "q" -- Allow formatting comments w/ gq
--     - "o" -- O and o, don't continue comments
--     + "r" -- But do continue when pressing enter.
--     + "n" -- Indent past the formatlistpat, not underneath it.
--     + "j" -- Auto-remove comments if possible.

-- Add asterisks in block comments
-- vim.opt.formatoptions:append({ 'r' })
--
-- vim.wo.signcolumn = 'yes'

-- for k, v in pairs(options) do
--   vim.opt[k] = v
-- end

-- Filetype

vim.opt.showmode = true

vim.filetype.add({
  extension = {
    conf = 'dosini',
  },
})

vim.filetype.add({
  ['.qss'] = 'css',
})

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- User Commands

-- vim.api.nvim_create_user_command('Nv', function()
--   vim.cmd('NvimTreeFocus')
-- end, { desc = 'Focus NvimTree' })
