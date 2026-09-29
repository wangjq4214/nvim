-- Wrap long Markdown lines visually without inserting newlines into the file.
vim.wo.wrap = true
vim.wo.linebreak = true

if pcall(vim.treesitter.start) then
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldmethod = "expr"
end
