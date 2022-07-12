local M = {}

M.load_keymap = function(mappings)
  local map_func
  local wk_ok, wk = pcall(require, 'which-key')

  if wk_ok then
    map_func = function(keybind, mapping_info, opts)
      wk.register({ [keybind] = mapping_info }, opts)
    end
  else
    map_func = function(keybind, mapping_info, opts)
      local mode = opts.mode
      opts.mode = nil
      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end

  for mode, mode_mappings in pairs(mappings) do
    for keybind, mapping_info in pairs(mode_mappings) do
      local opts = vim.tbl_deep_extend('force', { mode = mode }, mapping_info.opt or {
        noremap = true,
        silent = true
      })

      if mapping_info.opts then
        mapping_info.opts = nil
      end

      map_func(keybind, mapping_info, opts)
    end
  end
end

M.load_general_keymap = function()
  maps = {
    n = {
      ['<C-s>'] = { ':w<CR>', ' save this buffer' }
    }
  }

  M.load_keymap(maps)
end

return M

