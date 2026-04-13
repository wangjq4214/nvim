-- ---------------------------------------
-- | Wang Jinquan's Neovim configuration |
-- ---------------------------------------
--
-- This configuration is designed for Neovim 0.12 and later!
-- We will use new Neovim API for package management and configuration.
--
-- And this configuration is inspired by MiniMax.

-- Define a global table for utility functions
_G.utils = {}

-- Import mini pack
vim.pack.add { "https://github.com/nvim-mini/mini.nvim" }

-- Define a utility function by mini misc
local misc = require "mini.misc"

-- now function is executed immediately, we use it to set colorscheme, statusline,
-- tabline, etc. that should be loaded before everything else.
utils.now = function(f) misc.safely("now", f) end
-- later function is executed after everything else
utils.later = function(f) misc.safely("later", f) end
-- now_if_args function is executed immediately if there are command line
-- arguments, otherwise it is executed later.
utils.now_if_args = vim.fn.argc(-1) > 0 and utils.now or utils.later
-- on_event function is executed when a specific event occurs, we can use it to
-- set autocommands.
utils.on_event = function(ev, f) misc.safely("event:" .. ev, f) end
-- on_filetype function is executed when a specific filetype is detected, we can
-- use it to set filetype-specific settings.
utils.on_filetype = function(ft, f) misc.safely("filetype:" .. ft, f) end

-- Define a utility function to create normal mode key mappings with a description
utils.map = function(map_table)
  for k, tbl in pairs(map_table) do
    for _, v in ipairs(tbl) do
      vim.keymap.set(k, v[1], v[2], { desc = v[3] })
    end
  end
end

-- Define a utility function to create autocommands with a specific group and description
local gr = vim.api.nvim_create_augroup("custom-config", {})
utils.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- Define a utility function to execute a callback when a specific plugin is loaded or unloaded
utils.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end

    callback(ev.data)
  end

  utils.new_autocmd("PackChanged", "*", f, desc)
end
