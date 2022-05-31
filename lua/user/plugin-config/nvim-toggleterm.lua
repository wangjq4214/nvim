local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("toggleterm not found")
  return
end

toggleterm.setup({
  direction = "float",
})

local terminal = require("toggleterm.terminal").Terminal
local lazygit = terminal:new({ cmd = "lazygit", hidden = true })

LazygitToggle = function()
  lazygit:toggle({})
end

local keybindings = require("user.keybindings")
keybindings.toggleterm()
