vim.lsp.enable "gopls"
if pcall(vim.treesitter.start) then
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldmethod = "expr"
end
