-- stylua: ignore start

local status, builtin = pcall(require, "telescope.builtin")
if not status then
  return
end

local keymap = vim.keymap
local NS = { noremap = true, silent = true }

-- General keymaps
keymap.set("i", "jk", "<ESC>", NS) -- exit insert mode with jk
keymap.set("n", "<leader>wq", ":wq<CR>", NS) -- save and quit
keymap.set("n", "<leader>q", ":q!<CR>", NS) -- quit without saving
keymap.set("n", "W", ":w<CR>", NS)           -- save
keymap.set("n", "Q", ":bdelete<CR>", NS)     -- close buffer

-- Buffers
keymap.set("n", "H", ":BufferLineCyclePrev<cr>", NS)
keymap.set("n", "L", ":BufferLineCycleNext<cr>", NS)
keymap.set("n", "<leader>bb", ":e #<cr>", NS)

-- Tab management
keymap.set("n", "<localleader>to", ":tabnew<CR>") -- open a new tab
keymap.set("n", "<localleader>tx", ":tabclose<CR>") -- close a tab
keymap.set("n", "<localleader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<localleader>tp", ":tabp<CR>") -- previous tab
keymap.set("n", "<localleader>,", ":tabNext<CR>")

-- Quickfix keymaps
keymap.set("n", "<localleader>qo", ":copen<CR>") -- open quickfix list
keymap.set("n", "<localleader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<localleader>qn", ":cnext<CR>") -- jump to next quickfix list item
keymap.set("n", "<localleader>qp", ":cprev<CR>") -- jump to prev quickfix list item
keymap.set("n", "<localleader>ql", ":clast<CR>") -- jump to last quickfix list item
keymap.set("n", "<localleader>qc", ":cclose<CR>") -- close quickfix list

-- LSP keymaps
-- rename symbol
keymap.set("n", "<localleader>rl", "<cmd>lua vim.lsp.buf.rename()<CR>", NS)

--diagnotic keymaps
keymap.set("n", "gk", function() vim.diagnostic.jump({count= -1,float = true}) end, { desc = "Previous Diagnostic" })
keymap.set("n", "gj", function() vim.diagnostic.jump({count= 1,float = true}) end, { desc = "Next Diagnostic" })
-- keymap.set("n", "<leader>xx", function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Buffer diagnostics" })
-- keymap.set("n", "<leader>xX", function() builtin.diagnostics({ root_dir = true }) end, { desc = "cwd diagnostics" })
-- keymap.set("n", "<localleader>xx", vim.lsp.code_action, { desc = "Code Action" })
-- keymap.set("n", "<localleader>xX", LazyVim.lsp.action.source, { desc = "Source Action" })

-- dont yank on visual paste
keymap.set("v", "p", '"_dP', NS)

-- Cancel search highlighting with ESC
keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", NS)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", NS)

keymap.set("n", "vv", "V", NS)

keymap.set("v", "<", "<gv", { desc = "Stay in indent mode" })
keymap.set("v", ">", ">gv", { desc = "Stay in indent mode" })

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", NS)

-- Copilot Chat
keymap.set("n", "<leader>am", ":CopilotChatCommit<cr>", NS)

-- Treesj
keymap.set("n", "<leader>j", function()
  require("treesj").toggle({ split = { recusive = true } })
end, { noremap = true, silent = true, desc = "Toggle Split Join" })

-- System
keymap.set("n", "<leader>zc", ":e $MYVIMRC<cr>", { noremap = true, silent = true, desc = "Config" })
-- keymap.set("n", "<leader>zn", ":NoiceHistory<cr>", { noremap = true, silent = true, desc = "Notifications" })
keymap.set("n", "<leader>zh", ":checkhealth<cr>", { noremap = true, silent = true, desc = "Health" })
keymap.set("n", "<leader>zm", ":Mason<cr>", { noremap = true, silent = true, desc = "Mason" })
keymap.set("n", "<leader>zl", ":Lazy<cr>", { noremap = true, silent = true, desc = "Lazy" })
keymap.set("n", "<leader>za", ":messages<cr>", { desc = "Messages" })

keymap.set("n", "<leader>uc", function() require("nvchad.themes").open() end, { noremap = true, silent = true, desc = "ColorSchemes" })
-- FileBrowser
-- keymap.set("n", "<leader>e",":Nv<CR>", NS) -- toggle file explorer
-- keymap.set("n", "<leader>e",":NvimTreeFocus<CR>", NS) -- toggle file explorer
-- keymap.set("n", "<leader>e", function() Snacks.explorer() end, NS) -- toggle file explorer
-- keymap.set("n", "<localleader>E", ":Telescope file_browser<CR>", NS) -- toggle focus to file explorer

keymap.set("n", "gq", "<leader>cf", NS)
-- stylua: ignore end
