vim.lsp.enable "tombi"
vim.treesitter.start()

vim.pack.add {
  { src = "https://github.com/Saecki/crates.nvim" },
}

require('crates').setup()
