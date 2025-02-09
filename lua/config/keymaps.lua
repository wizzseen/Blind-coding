-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable Visual Mode
vim.keymap.set("", "v", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "V", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "<C-v>", "<Nop>", { noremap = true, silent = true }) -- Block Visual Block mode

-- Disable Yank (copy)
vim.keymap.set("n", "y", '"_y', { noremap = true, silent = true })
vim.keymap.set("n", "Y", '"_Y', { noremap = true, silent = true })
vim.keymap.set("v", "y", '"_y', { noremap = true, silent = true })
vim.keymap.set("v", "d", '"_d', { noremap = true, silent = true }) -- Delete without copying
vim.keymap.set("n", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true }) -- Cut without copying

-- Disable Paste (p)
vim.keymap.set("n", "p", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "P", "<Nop>", { noremap = true, silent = true })
require("config.my_floating_menu") -- Load floating menu setup
require("config.run_code")
