local M = {}

vim.cmd([[
function! Quit_vim(a, b, c, d)
  qa
endfunction
]])

local options = {
  options = {
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %s",

    offsets = {
      {
        filetype = "NvimTree",
        text_align = "left",
        padding = 1
      }
    },
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    show_close_icon = false,
    left_trunc_marker = " ",
    right_trunc_marker = " ",
    max_name_length = 20,
    max_prefix_length = 13,
    tab_size = 20,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    show_buffer_close_icons = true,
    separator_style = "thin",
    themable = true,

    -- top right buttons in bufferline
    custom_areas = {
      right = function()
        return {
          { text = "%@Quit_vim@ %X" },
        }
      end,
    },

    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
}

M.setup = function()
  local lazy_load = require("plugins.lazy_load").lazy_load

  lazy_load({
    events = { "BufRead", "BufNewFile", "TabEnter" },
    augroup_name = "BufferlineLazy",
    plugins = "bufferline.nvim",
    condition = function()
      return #vim.fn.getbufinfo({ buflisted = 1 }) >= 2
    end
  })
end

M.config = function()
  local ok, bufferline = pcall(require, "bufferline")

  if not ok then
    return
  end

  bufferline.setup(options)
end

return M

