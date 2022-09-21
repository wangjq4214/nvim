local util = require('util')

local api, fn = vim.api, vim.fn
local config_path = fn.stdpath('config')
local data_path = fn.stdpath('data')

local _packer = nil

local _setup = {}

-- ensure_packer will install packer
function _setup:ensure_packer()
  local install_path = data_path .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) == 0 then
    return
  end

  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- load_packer will load packer.nvim to _packer and init it
function _setup:load_packer()
  -- check if _packer is nil
  if not _packer then
    api.nvim_command('packadd packer.nvim')
    _packer = require('packer')
  end

  _packer.init({
    disable_commands = true,
    display = {
      open_fn = require('packer.util').float,
      working_sym = 'ﰭ',
      error_sym = '',
      done_sym = '',
      removed_sym = '',
      moved_sym = 'ﰳ',
    },
    git = { clone_timeout = 120 },
    autoremove = true
  })
  _packer.reset()
end

-- scan_files will scan files named plugins.lua and require them
function _setup:scan_files()
  local get_plugins_list = function()
    local pattern = util:join_paths('lua', '(.+).lua$')
    local list = {}
    local tmp = vim.split(fn.globpath(config_path, '**/plugins.lua'), '\n')

    for _, f in ipairs(tmp) do
      list[#list + 1] = string.match(f, pattern)
    end

    return list
  end

  local plguins_file = get_plugins_list()
  for _, m in ipairs(plguins_file) do
    require(m)
  end
end

-- load_plugins will scan config files and load them
function _setup:load_plugins()
  self.repos = {}

  -- get plguin file
  self:scan_files()

  -- load plugins
  local use = _packer.use
  -- manager itself
  use({ 'wbthomason/packer.nvim', opt = true })

  -- other plugins
  for _, repo in ipairs(self.repos) do
    use(repo)
  end
end

-- export module which can return _setup and raw packer
local M = setmetatable({}, {
  __index = function(_, key)
    if key == 'setup' then
      return _setup
    end

    if not _packer then
      _setup:ensure_packer()
      _setup:load_packer()
      _setup:load_plugins()
    end

    return _packer[key]
  end
})

-- add a plugin to _setup.repos so that we can manage them
function M.add(repo)
  if not _setup.repos then
    _setup.repos = {}
  end

  table.insert(_setup.repos, repo)
end

function M.load()
  -- register packer cmd
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
      M[string.lower(cmd)]()
    end, {})
  end

  -- auto compile
  api.nvim_create_autocmd('BufWritePost', {
    pattern = 'plugins.lua',
    callback = function()
      _packer.compile()
    end,
    desc = 'Auto Compile the neovim config which write in lua'
  })
end

return M
