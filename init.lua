-- ═══════════════════════════════════════════════════════════════
-- STARTER CONFIG
-- Install and enable plugins/language_servers: 
-- 1. lazy
-- 2. lua_ls 
-- 3. oil
-- 4. telescope
-- ═══════════════════════════════════════════════════════════════

require("config.lazy")

local uv = vim.uv
print("Using: " .. uv.os_getenv("NVIM_APPNAME"))

-- ==== GREAT Advent of Neovim ====
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- Personal
vim.keymap.set("n", "<space>nh", "<cmd>noh<CR>")
vim.keymap.set("n", "-", "<cmd>Oil<CR>")


-- Basic
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.api.nvim_set_hl(0, "Comment", { fg = "#FF2A54", italic = true })
vim.opt.scrolloff = 10


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({higroup='DiffText', timeout=300})
  end,
})

-- ==== Terminal
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Custom terminal setup',
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.linebreak = false
  end,
})

vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)
end)

-- Enable lsps
vim.lsp.enable("lua_ls")
