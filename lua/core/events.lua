local api, fn = vim.api, vim.fn
local self_group = api.nvim_create_augroup('Wangjq4214Event', {})

api.nvim_create_autocmd(
  { 'BufEnter' },
  {
    pattern = '*',
    group = self_group,
    callback = function()
      if fn.winnr('$') == 1 and fn.bufname() == 'NvimTree_' .. fn.tabpagenr() then
        api.nvim_command('quit')
      end
    end
  }
)
