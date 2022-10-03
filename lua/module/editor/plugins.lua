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

add({
  'lukas-reineke/indent-blankline.nvim',
  after = 'nvim-treesitter',
  config = cfg.indent_blankline
})

add({
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = cfg.gitsigns,
  requires = { 'nvim-lua/plenary.nvim', opt = true },
})

add({
  'numToStr/Comment.nvim',
  event = 'BufRead',
  config = cfg.comment
})
