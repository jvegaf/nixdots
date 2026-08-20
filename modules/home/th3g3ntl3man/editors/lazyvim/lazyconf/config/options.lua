vim.g.lazyvim_blink_main = true
-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
vim.g.lazyvim_picker = "snacks"

-- Statuscolumn: snacks' own implementation (satisfies its health check).
-- LazyVim's default (%!v:lua.LazyVim.statuscolumn()) delegates to snacks too,
-- but the health check looks for the literal `snacks.statuscolumn` string.
vim.opt.statuscolumn = [[%!v:lua.require('snacks.statuscolumn').get()]]

-- Treesitter-based folds (native, no nvim-ufo). LazyVim's own foldexpr
-- falls back to "0" when the buffer has no treesitter parser.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.LazyVim.treesitter.foldexpr()"

vim.filetype.add({
	extension = {
		conf = "dosini",
	},
})

vim.filetype.add({
	extension = {
		qss = "css",
	},
	-- ['.qss'] = 'css',
})

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- User Commands

vim.api.nvim_create_user_command("Nv", function()
	vim.cmd("NvimTreeFocus")
end, { desc = "ToVertical" })

vim.api.nvim_create_user_command("OneWordPerLine", function(opts)
	local line1 = opts.line1
	local line2 = opts.line2

	vim.cmd(string.format([[%d,%ds/\s\+/\r/g]], line1, line2))
end, { range = "%" })
