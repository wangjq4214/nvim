local M = {}

M.lazy_load = function(tb)
  vim.api.nvim_create_autocmd(tb.events, {
    pattern = "*",
    group = vim.api.nvim_create_augroup(tb.augroup_name, {}),
    callback = function()
      if tb.condition() then
        vim.api.nvim_del_augroup_by_name(tb.augroup_name)

        if tb.plugins ~= "nvim-treesitter" then
          vim.defer_fn(function()
            vim.cmd("PackerLoad " .. tb.plugins)
          end, 0)
        else
          vim.cmd("PackerLoad " .. tb.plugins)
        end
      end
    end
  })
end

return M
