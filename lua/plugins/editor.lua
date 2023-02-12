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
}

