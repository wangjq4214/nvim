local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("which-key not found")
  return
end

which_key.setup()
