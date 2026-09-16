vim.lsp.enable "tombi"
if pcall(vim.treesitter.start) then
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldmethod = "expr"
end

vim.pack.add {
  { src = "https://github.com/Saecki/crates.nvim" },
}

require('crates').setup()
