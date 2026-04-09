-- __   __   ___   __  __             ___     ___    _  _      ___    ___     ___
-- \ \ / /  |_ _| |  \/  |    o O O  / __|   / _ \  | \| |    | __|  |_ _|   / __|
--  \ V /    | |  | |\/| |   o      | (__   | (_) | | .` |    | _|    | |   | (_ |
--  _\_/_   |___| |_|__|_|  TS__[O]  \___|   \___/  |_|\_|   _|_|_   |___|   \___|
--_|""""|_|"""""|_|"""""| {======|_|"""""|_|"""""|_|"""""|_|""""|_|"""""|_|"""""|
--`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'

-- Allow Lua to require installed luarocks packages
-- package.path = package.path .. ";~/.luarocks/share/lua/5.1/magick/init.lua;"

-- Load settings before plugins so that <leader> key is defined
require('settings')

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('plugins')
require('theme')
require('mappings')
require('autocommands')
