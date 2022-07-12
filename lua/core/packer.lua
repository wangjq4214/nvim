-- Bootstrap packer.nvim

local fn, uv, api = vim.fn, vim.loop, vim.api
local vim_path = fn.stdpath('config')
local data_dir = string.format('%s/site/', fn.stdpath('data'))
local modules_dir = vim_path .. '/lua/modules'
local packer_compiled = data_dir .. 'lua/packer_compiled.lua'
local packer = nil

local Packer = {}
Packer.__index = M

-- load plugins from `modules` dir
function Packer:load_plugins()
  self.repos = {}

  local get_plugins_list = function()
    local list = {}
    local tmp = vim.split(fn.globpath(modules_dir, '*/plugins.lua'), '\n')
    for _, f in ipairs(tmp) do
      list[#list+1] = string.match(f, 'lua/(.+).lua$')
    end
    return list
  end

  local plugins_file = get_plugins_list()
  for _, m in ipairs(plugins_file) do
    require(m)
  end
end

-- bootstrap packer.nvim use packadd command
function Packer:load_packer()
  if not packer then
    api.nvim_command('packadd packer.nvim')
    packer = require('packer')
  end

  packer.init({
    compile_path = packer_compiled,
    git = { clone_timeout = 120 },
    disable_commands = true,
  })
  packer.reset()

  self:load_plugins()
  
  local use = packer.use
  use({ 'wbthomason/packer.nvim', opt = true })
  for _, repo in ipairs(self.repos) do
    use(repo)
  end
end

-- clone packer.nvim
function Packer:init_ensure_plugins()
  local packer_dir = data_dir .. 'pack/packer/opt/packer.nvim'
  local state = uv.fs_stat(packer_dir)
  if not state then
    local cmd = '!git clone https://github.com/wbthomason/packer.nvim ' .. packer_dir
    api.nvim_command(cmd)
    uv.fs_mkdir(data_dir .. 'lua', 511, function()
      assert('make compile path dir failed')
    end)
    self:load_packer()
    packer.sync()
  end
end

local M = setmetatable({}, {
  __index = function(_, key)
    if not packer then
      Packer:load_packer()
    end
    return packer[key]
  end
})

function M.ensure_plugins()
  Packer:init_ensure_plugins()
end

function M.register_plugin(repo)
  table.insert(Packer.repos, repo)
end

function M.auto_compile()
  local file = fn.expand('%:p')
  if not file:match(vim_path) then
    return
  end

  if file:match('plugins.lua') then
    M.clean()
  end
  M.compile()
  require('packer_compiled')
end

function M.load_compile()
  if fn.filereadable(packer_compiled) == 1 then
    require('packer_compiled')
  else
    vim.notify('Run PackerSync or PackerCompile', 'info', { title = 'Packer' })
  end

  local cmds = {
    'Compile',
    'Install',
    'Update',
    'Sync',
    'Clean',
    'Status',
  }

  for _, cmd in ipairs(cmds) do
    api.nvim_create_user_command('Packer' .. cmd, function()
      require('core.packer')[fn.tolower(cmd)]()
    end, {})
  end

  local PackerHooks = api.nvim_create_augroup('PackerHooks', {})
  api.nvim_create_autocmd('User', {
    pattern = 'PackerCompileDone',
    callback = function()
      vim.notify('Compile Done!', vim.log.levels.INFO, { title = 'Packer' })
    end,
    group = PackerHooks,
  })
end

return M

