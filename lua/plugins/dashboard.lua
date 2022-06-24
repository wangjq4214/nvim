local M = {}

M.config = function()
  local status, db = pcall(require, "dashboard")
  if not status then
    return
  end

  db.custom_footer = function()
    local footer = { "", "https://github.com/wangjq4214", "" }
    if packer_plugins ~= nil then
      local count = #vim.tbl_keys(packer_plugins)
      footer[3] = "🎉 neovim loaded " .. count .. " plugins"
    end
    return footer
  end

  db.custom_center = {
    { icon = "  ", desc = "Projects", action = "Telescope projects" },
    { icon = "  ", desc = "Recently files", action = "Telescope oldfiles" },
    { icon = "  ", desc = "Find file", action = 'Telescope find_files'},
    { icon = "  ", desc = "Find text", action = 'Telescope live_grep'},
    {
      icon = "  ",
      desc = "Edit keybindings",
      action = "edit" .. vim.fn.stdpath("config") .. "/lua/core/mappings.lua",
    },
    -- {
      -- icon = "  ",
      -- desc = "Edit Projects",
      -- action = "edit ~/.local/share/nvim/project_nvim/project_history",
    -- },
    -- e = { description = { "  Edit .bashrc          " }, command = "edit ~/.bashrc" },
    -- f = { description = { "  Edit init.lua         " }, command = "edit ~/.config/nvim/init.lua" },
    -- g = { description = {'  Find file          '}, command = 'Telescope find_files'},
    -- h = { description = {'  Find text          '}, command = 'Telescope live_grep'},
  }

  db.custom_header = {
    [[]],
    [[]],
    [[██╗    ██╗ █████╗ ███╗   ██╗ ██████╗      ██╗ ██████╗ ]],
    [[██║    ██║██╔══██╗████╗  ██║██╔════╝      ██║██╔═══██╗]],
    [[██║ █╗ ██║███████║██╔██╗ ██║██║  ███╗     ██║██║   ██║]],
    [[██║███╗██║██╔══██║██║╚██╗██║██║   ██║██   ██║██║▄▄ ██║]],
    [[╚███╔███╔╝██║  ██║██║ ╚████║╚██████╔╝╚█████╔╝╚██████╔╝]],
    [[ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚════╝  ╚══▀▀═╝ ]],
    [[                                                      ]],
  }
end

return M
