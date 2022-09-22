local M = {}

function M.nvim_tree()
  require('nvim-tree').setup({
    view = {
      width = 30,
      height = 30,
      side = 'left',
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = 'yes',
      hide_root_folder = false,
      mappings = {
        list = {
          { key = { 'l' }, action = 'edit' },
          { key = { 's' }, action = 'split' },
          { key = { 'v' }, action = 'vsplit' },
        },
      },
    },
    renderer = {
      icons = {
        glyphs = {
          default = '',
          symlink = '',
          folder = {
            arrow_closed = '',
            arrow_open = '',
            default = '',
            empty = '',
            empty_open = '',
            open = '',
            symlink = '',
            symlink_open = '',
          },
          git = {
            deleted = '',
            ignored = '',
            renamed = '',
            staged = '',
            unmerged = '',
            unstaged = '',
            untracked = 'ﲉ',
          },
        },
      },
    },
  })
end

function M.telescope()

end

return M
