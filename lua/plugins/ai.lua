---@type LazySpec
return {
  "yetone/avante.nvim",
  opts = {
    provider = "kimi",
    providers = {
      kimi = {
        __inherited_from = "openai",
        endpoint = "https://api.moonshot.cn/v1",
        api_key_name = "KIMI_API_KEY",
        model = "kimi-k2-0711-preview",
        extra_request_body = {
          max_tokens = -1,
          temperature = 0.6,
        },
      },
    },
  },
}
