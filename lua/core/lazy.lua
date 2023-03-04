-- Install the package management plugin and perform initialization settings.

vim.g.mapleader = ' '
vim.g.localleader = ' '

-- Install the lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', lazypath })
  vim.fn.system({ 'git', '-C', lazypath, 'checkout', 'tags/stable' })
end
vim.opt.rtp:prepend(lazypath)

-- Setup the lazy config
require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  defaults = { lazy = true },
  install = { colorscheme = { 'tokyonight', 'habamax' } },
  checker = { enabled = true },
  diff = { cmd = 'terminal_git' },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'rplugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin'
      },
    },
  },
  ui = {
    custom_keys = {
      ['<localleader>d'] = function(plugin)
        dd(plugin)
      end
    }
  },
  debug = false,
})

