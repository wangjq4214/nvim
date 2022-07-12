local nvim_tree_keymap = {
  -- open file or dir
  { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
  -- split to open file
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- hidden or show filters
  { key = "i", action = "toggle_custom" }, -- filters custom options (node_modules)
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- file operation
  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "s", action = "system_open" },
}

local M = {}

M.nvim_tree = function()
  local ok, module = pcall(require, 'nvim-tree')
  if not ok then
    return
  end

  module.setup({
    -- disable git status icon
    git = {
      enable = false,
    },
    -- project plugin settings
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    -- hidden dotfile and node_modules dir
    filters = {
      dotfiles = true,
      custom = { 'node_modules' },
    },
    view = {
      width = 40,
      side = 'left',
      -- hidden root folder
      hide_root_folder = false,
      -- custom keymap
      mappings = {
        custom_only = false,
        list = nvim_tree_keymap,
      },
      -- disable line number
      number = false,
      relativenumber = false,
      -- display icon
      signcolumn = 'yes',
    },
    actions = {
      open_file = {
        resize_window = true,
        quit_on_open = true,
      },
    },
  })

  vim.cmd([[
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
  ]])
end

M.nvim_bufferline = function()
  local ok, bufferline = pcall(require, 'bufferline')
  if not ok then
    return
  end

  bufferline.setup({
    options = {
      -- close_command = 'Bdelete! %d',
      -- right_mouse_commad = 'Bdelete! %d',

      -- offset for nvim tree
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
      -- lsp config
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. n .. sym
        end
        return s
      end,
    },
  })
end

return M

