---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    event = "User AstroFile",
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanionActions",
    },
    config = function()
      require("codecompanion").setup {
        strategies = {
          chat = {
            adapter = "deepseek",
          },
          inline = {
            adapter = "deepseek",
          },
          cmd = {
            adapter = "deepseek",
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {

    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>aa"] = {
            function() vim.cmd "CodeCompanionActions" end,
            desc = "Open codecompanion actions panel",
          },
          ["<Leader>ai"] = {
            function() vim.cmd "CodeCompanion" end,
            desc = "Open codecompanion inline assistant",
          },
          ["<Leader>ac"] = {
            function() vim.cmd "CodeCompanionChat" end,
            desc = "Open codecompanion chat buffer",
          },
        },
      },
    },
  },
}
