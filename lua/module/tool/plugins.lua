local add = require('core.packer').add
local cfg = require('module.tool.configs')

add({
  'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  config = cfg.nvim_tree,
  requires = {
    'kyazdani42/nvim-web-devicons',
  }
})

-- don't have config
add({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  requires = {
    { 'nvim-lua/plenary.nvim', opt = true },
    { 'nvim-telescope/telescope-fzy-native.nvim', opt = true },
    { 'nvim-telescope/telescope-file-browser.nvim', opt = true }
  }
})
