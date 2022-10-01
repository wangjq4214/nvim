local add      = require('core.packer').add
local cfg      = require('module.lsp.configs')
local filetype = require('util.filetype')

add({
  'neovim/nvim-lspconfig',
  ft = filetype.enable_lsp_filetype,
  config = cfg.lspconfig
})

add({
  'williamboman/mason.nvim',
  config = cfg.mason
})

add({
  'williamboman/mason-lspconfig.nvim',
  requires = 'williamboman/mason.nvim',
  config = cfg.mason_lspconfig
})

add({
  'glepnir/lspsaga.nvim',
  branch = 'main',
  after = 'nvim-lspconfig'
})

add({
  'hrsh7th/nvim-cmp',
  config = cfg.nvim_cmp,
  requires = {
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
  }
})

add({
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = cfg.auto_pairs,
  requires = 'hrsh7th/nvim-cmp'
})
