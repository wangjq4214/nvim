local add = require('core.packer').add
local cfg = require('module.editor.configs')

add({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  after = 'telescope.nvim',
  config = cfg.nvim_treesitter
})

add({
  'nvim-treesitter/nvim-treesitter-textobjects',
  after = 'nvim-treesitter'
})
