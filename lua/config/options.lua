-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Add any additional options here
--
--
vim.schedule(function()
  dofile(vim.fn.stdpath("config") .. "/lua/config/keymaps.lua")
end)
-- 
