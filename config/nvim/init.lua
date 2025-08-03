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
require('plugins')
require('theme')
require('mappings')
require('autocommands')
