local nvim_tree_keymap = {
  -- open file or dir
  { key = { '<CR>', 'o', '<2-LeftMouse>' }, action = 'edit' },
  -- split to open file
  { key = 'v', action = 'vsplit' },
  { key = 'h', action = 'split' },
  -- hidden or show filters
  { key = 'i', action = 'toggle_custom' }, -- filters custom options (node_modules)
  { key = '.', action = 'toggle_dotfiles' }, -- Hide (dotfiles)
  -- file operation
  { key = '<F5>', action = 'refresh' },
  { key = 'a', action = 'create' },
  { key = 'd', action = 'remove' },
  { key = 'r', action = 'rename' },
  { key = 'x', action = 'cut' },
  { key = 'c', action = 'copy' },
  { key = 'p', action = 'paste' },
  { key = 's', action = 'system_open' },
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
    respect_buf_cwd = true,
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
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or '')
          s = s .. n .. sym
        end
        return s
      end,
    },
  })
end

M.nvim_telescope = function()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    return 
  end

  telescope.setup({
    defaults = {
      -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
      initial_mode = 'insert',
      -- 窗口内快捷键
      mappings = {
        i = {
          -- 上下移动
          ['<C-j>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
          ['<Down>'] = 'move_selection_next',
          ['<Up>'] = 'move_selection_previous',
          -- 历史记录
          ['<C-n>'] = 'cycle_history_next',
          ['<C-p>'] = 'cycle_history_prev',
          -- 关闭窗口
          ['<C-c>'] = 'close',
          -- 预览窗口上下滚动
          ['<C-u>'] = 'preview_scrolling_up',
          ['<C-d>'] = 'preview_scrolling_down',
        },
      },
    },
    pickers = {
      -- 内置 pickers 配置
      find_files = {
        -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
        theme = 'dropdown', 
      },
      live_grep = {
        theme = 'dropdown',
      },
      oldfiles = {
        theme = 'dropdown',
      },
    },
    extensions = {
      -- 扩展插件配置
    },
  })

  pcall(telescope.load_extension, 'env')
end

M.telescope_project = function()
  local ok, project = pcall(require, 'project_nvim')
  if not ok then
    return
  end

  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    return
  end

  project.setup({
    detection_methods = { 'pattern' },
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.sln' },
  })

  pcall(telescope.load_extension, 'projects')
end

return M

