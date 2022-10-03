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

add({
  'akinsho/bufferline.nvim',
  tag = "v2.*",
  events = { 'BufAdd' },
  config = cfg.bufferline,
  requires = 'kyazdani42/nvim-web-devicons'
})

-- don't have config
add({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = cfg.telescope,
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-project.nvim' }
  }
})
