require("core.options")

vim.defer_fn(
  function()
    require("core.mappings").load_mappings()
  end,
  0
)

require("core.packer").bootstrap()
require("plugins").setup()
require("ui")
