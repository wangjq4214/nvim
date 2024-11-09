return {
  -- use avante to cmp the code with deepseek
  {
    "yetone/avante.nvim",
    opts = {
      provider = "deepseek",
      vendors = {
        -- @type AvanteProvider
        ["deepseek"] = {
          endpoint = "https://api.deepseek.com/chat/completions",
          model = "deepseek-coder",
          api_key_name = "DEEPSEEK_API_KEY",
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint,
              headers = {
                ["Accept"] = "application/json",
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
              },
              body = {
                model = opts.model,
                messages = require("avante.providers").copilot.parse_messages(code_opts),
                temperature = 0,
                max_tokens = 4096,
                stream = true,
              },
            }
          end,
          --
          parse_response_data = function(data_stream, event_state, opts)
            require("avante.providers").copilot.parse_response(data_stream, event_state, opts)
          end,
        },
      },
    },
  },
}
