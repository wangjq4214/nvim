local new_autocmd = utils.new_autocmd

new_autocmd("VimEnter", "*", function()
  if vim.fn.argc(-1) == 1 then
    local arg = vim.fn.argv(0)
    if vim.fn.isdirectory(arg) == 1 then vim.cmd ":Neotree" end
  end
end, "Open Neotree when opening a directory")
