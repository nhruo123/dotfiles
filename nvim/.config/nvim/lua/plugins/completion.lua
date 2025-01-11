return {
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'rcarriga/cmp-dap',
    },

    event = { 'InsertEnter', 'CmdlineEnter' },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function()
        return vim.bo.buftype ~= 'prompt' or require('cmp_dap').is_dap_buffer()
      end,
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = 'default',
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
        cmdline = {
          preset = 'default',
          ['<Tab>'] = { 'show', 'select_next' },
          ['<S-Tab>'] = { 'show', 'select_prev' },
        },
      },
      completion = {
        menu = {
          border = 'rounded',
          auto_show = function(ctx)
            return ctx.mode ~= 'cmdline'
          end,
        },
        list = {
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= 'cmdline'
            end,
            auto_insert = true,
          },
        },
        documentation = {
          window = { border = 'rounded' },
        },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true, window = { border = 'rounded' } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'dap' },
        providers = {
          dap = {
            name = 'dap',
            module = 'blink.compat.source',
            enabled = function()
              return require('cmp_dap').is_dap_buffer()
            end,
          },
        },
      },
    },
  },
}
