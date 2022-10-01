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

function M.bufferline()
  require('bufferline').setup({
    options = {
      diagnostics = 'nvim_lsp',
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          text_align = 'left',
          separator = true
        }
      },
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local sym = e == 'error' and ' '
              or (e == 'warning' and ' ' or '')
          s = s .. n .. sym
        end
        return s
      end
    }
  })
end

function M.telescope()

end

return M
