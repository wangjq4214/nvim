local add = require('core.packer').add
local cfg = require('module.ui.configs')

add({
  'folke/tokyonight.nvim',
  config = cfg.tokyonight
})

add({
  'nvim-lualine/lualine.nvim',
  config = cfg.lualine,
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
})
