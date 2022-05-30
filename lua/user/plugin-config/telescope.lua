local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found")
  return
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- 窗口内快捷键
    mappings = require("user.keybindings").telescope_list,
  },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
      -- theme = "dropdown", 
    }
  },
  extensions = {
    -- 扩展插件配置
  },
})

pcall(telescope.load_extension, "env")

