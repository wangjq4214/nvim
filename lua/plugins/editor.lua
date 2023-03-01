function telescope_util(builtin, opts)
  local params = { builtin = builtin, opts = opts }

  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend('force', { cwd = require('utils').get_root() }, opts or {})

    if builtin == 'files' then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. '/.git') then
        opts.show_untracked = true
        builtin = 'git_files'
      else
        builtin = 'find_files'
      end
    end

    return require('telescope.builtin')[builtin](opts)
  end
end

return {
  -- file explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      {
        '<leader>fe',
        function()
          require('neo-tree.command').execute({ toggle = true, dir = require('utils').get_root() })
        end,
        desc = 'Explorer Neotree (root dir)'
      },
      {
        '<leader>fE',
        function()
          require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = 'Explorer Neotree (cwd)'
      },
      { '<leader>e', '<leader>fe', desc = 'Explorer Neotree (root dir)', remap = true },
      { '<leader>E', '<leader>fE', desc = 'Explorer Neotree (cwd)', remap = true },
    },
    deactivate = function()
      vim.cmd([[ Neotree close ]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
    end,
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        position = 'right',
        mappings = {
          ['<space>'] = 'none'
        }
      }
    },
  },
  -- search/replace in multiple files
  {
    'nvim-pack/nvim-spectre',
    keys = {
      {
        '<leader>sr',
        function()
          require('spectre').open()
        end,
        desc = 'Replace in files (Spectre)'
      }
    },
  },
  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    keys = {
      { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch Buffer' },
      { '<leader>/', telescope_util('live_grep'), desc = 'Find in Files (Grep)' },
      { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader><space>', telescope_util('files'), desc = 'Find Files (root dir)' },
      -- find
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '<leader>ff', telescope_util('files'), desc = 'Find Files (root dir)' },
      { '<leader>fF', telescope_util('files', { cwd = false }), desc = 'Find files (cwd)' },
      { '<leader>fr', '<cmd>Telescope old files<cr>', desc = 'Recent' },
      -- git
      { '<leader>gc', '<cmd>Telescope git_commits<cr>', desc = 'Commits' },
      { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Status' },
      -- search
      { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Auto command' },
      { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
      { '<leader>sc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>sC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
      { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
      { '<leader>sg', telescope_util('live_grep'), desc = 'Grep (root dir)' },
      { '<leader>sG', telescope_util('live_grep', { cwd = false }), desc = 'Grep (cwd)' },
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
      { '<leader>sH', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
      { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
      { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'Jump to Mark' },
      { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
      { '<leader>sw', telescope_util('grep_string'), desc = 'Word (root dir)' },
      { '<leader>sW', telescope_util('grep_string', { cwd = false }), desc = 'Word (cwd)' },
      { '<leader>uC', telescope_util('colorscheme', { enable_preview = true }), desc = 'Colorscheme with preview' },
      {
        '<leader>ss',
        telescope_util('lsp_document_symbols', {
          symbols = {
            'Class',
            'Function',
            'Method',
            'Constructor',
            'Interface',
            'Module',
            'Struct',
            'Trait',
            'Field',
            'Property',
          },
        }),
        desc = 'Goto Symbol',
      },
    },
    opts = {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
        mappings = {
          i = {
            ['<c-t>'] = function(...)
              return require('trouble.providers.telescope').open_with_trouble(...)
            end,
            ['<a-i>'] = function()
              telescope_util('find_files', { no_ignore = true })()
            end,
            ['<a-h>'] = function()
              telescope_util('find_files', { hidden = true })()
            end,
            ['<C-Down>'] = function(...)
              return require('telescope.actions').cycle_history_next(...)
            end,
            ['<C-Up>'] = function(...)
              return require('telescope.actions').cycle_history_prev(...)
            end,
            ['<C-f>'] = function(...)
              return require('telescope.actions').preview_scrolling_down(...)
            end,
            ['<C-b>'] = function(...)
              return require('telescope.actions').preview_scrolling_up(...)
            end,
          },
          n = {
            ['q'] = function(...)
              return require('telescope.actions').close(...)
            end,
          },
        },
      },
    },
  },
  -- easily jump to any location and enhanced f/t motions for Lead
  {
    'ggandor/leap.nvim',
    event = 'VeryLazy',
    dependencies = { { 'ggandor/flit.nvim', opts = { labeled_modes = 'nv' } } },
    config = function(_, opts)
      local leap = require('leap')
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end,
  },
  -- git signs
  {
    'lewis6991/gitsigns.nvim',
  },
}

