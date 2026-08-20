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
augroup("discontinue_comments", { clear = true })
autocmds({ "FileType" }, {
	pattern = { "*" },
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - "o"
	end,
	group = "discontinue_comments",
	desc = "Dont't continue comments with o/O",
})

autocmds({ "BufRead", "BufNewFile" }, {
	pattern = "*.qss",
	command = "set filetype=css",
})

autocmds({ "BufRead", "BufNewFile" }, {
	pattern = "*.tpl",
	command = "set filetype=html",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	command = "setlocal noexpandtab",
})

autocmds("InsertLeave", {
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
