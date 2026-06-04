local map = utils.map

vim.lsp.enable "tinymist"
vim.treesitter.start()

vim.pack.add {
  "https://github.com/chomosuke/typst-preview.nvim",
}

vim.o.wrap = true

map {
  n = {
    { "<Leader>op", "<Cmd>LspTinymistPinMain<CR>", "typst pin main" },
  },
}
