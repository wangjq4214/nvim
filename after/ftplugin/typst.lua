local map = utils.map

vim.lsp.enable "tinymist"
if pcall(vim.treesitter.start) then
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldmethod = "expr"
end

vim.pack.add {
  "https://github.com/chomosuke/typst-preview.nvim",
}

vim.o.wrap = true

map {
  n = {
    { "<Leader>op", "<Cmd>LspTinymistPinMain<CR>", "typst pin main" },
  },
}
