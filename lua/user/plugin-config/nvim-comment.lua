local status, Comment = pcall(require, "Comment")
if not status then
  vim.notify("Comment not found")
  return
end

Comment.setup()
