-- return { -- Autocompletion
--   'hrsh7th/nvim-cmp',
--   event = 'InsertEnter',
--   dependencies = {
--     -- Snippet Engine & its associated nvim-cmp source
--     'onsails/lspkind.nvim',
--     'lukas-reineke/cmp-under-comparator',
--     {
--       'L3MON4D3/LuaSnip',
--       build = (function()
--         -- Build Step is needed for regex support in snippets
--         -- This step is not supported in many windows environments
--         -- Remove the below condition to re-enable on windows
--         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
--           return
--         end
--         return 'make install_jsregexp'
--       end)(),
--     },
--     'saadparwaiz1/cmp_luasnip',
--
--     -- Adds other completion capabilities.
--     --  nvim-cmp does not ship with all sources by default. They are split
--     --  into multiple repos for maintenance purposes.
--     'hrsh7th/cmp-nvim-lsp',
--     'hrsh7th/cmp-path',
--     'hrsh7th/cmp-buffer',
--
--     'rafamadriz/friendly-snippets',
--
--     'rcarriga/cmp-dap',
--   },
--   config = function()
--     require('luasnip.loaders.from_vscode').lazy_load()
--     -- See `:help cmp`
--     local cmp = require 'cmp'
--     local luasnip = require 'luasnip'
--     local lspkind = require 'lspkind'
--     luasnip.config.setup {}
--     cmp.setup {
--       -- preselect = cmp.PreselectMode.None
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       formatting = {
--         format = lspkind.cmp_format {
--           mode = 'symbol_text',
--           maxwidth = function()
--             return math.floor(0.45 * vim.o.columns)
--           end,
--           ellipsis_char = '...',
--           menu = {
--             nvim_lsp = '[LSP]',
--             luasnip = '[LuaSnip]',
--             buffer = '[Buffer]',
--             nvim_lua = '[Lua]',
--             latex_symbols = '[Latex]',
--           },
--         },
--       },
--       completion = { completeopt = 'menu,menuone,noinsert' },
--       -- For an understanding of why these mappings were
--       -- chosen, you will need to read `:help ins-completion`
--       --
--       -- No, but seriously. Please read `:help ins-completion`, it is really good!
--       mapping = cmp.mapping.preset.insert {
--         -- Select the [n]ext item
--         ['<C-n>'] = cmp.mapping.select_next_item(),
--         -- Select the [p]revious item
--         ['<C-p>'] = cmp.mapping.select_prev_item(),
--
--         -- Accept ([y]es) the completion.
--         --  This will auto-import if your LSP supports it.
--         --  This will expand snippets if the LSP sent a snippet.
--         ['<C-y>'] = cmp.mapping.confirm { select = true },
--
--         -- Manually trigger a completion from nvim-cmp.
--         --  Generally you don't need this, because nvim-cmp will display
--         --  completions whenever it has completion options available.
--         ['<C-Space>'] = cmp.mapping.complete {},
--
--         -- Think of <c-l> as moving to the right of your snippet expansion.
--         --  So if you have a snippet that's like:
--         --  function $name($args)
--         --    $body
--         --  end
--         --
--         -- <c-l> will move you to the right of each of the expansion locations.
--         -- <c-h> is similar, except moving you backwards.
--         ['<C-l>'] = cmp.mapping(function()
--           if luasnip.expand_or_locally_jumpable() then
--             luasnip.expand_or_jump()
--           end
--         end, { 'i', 's' }),
--         ['<C-h>'] = cmp.mapping(function()
--           if luasnip.locally_jumpable(-1) then
--             luasnip.jump(-1)
--           end
--         end, { 'i', 's' }),
--       },
--       sources = {
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--         { name = 'path' },
--         { name = 'buffer' },
--       },
--       sorting = {
--         comparators = {
--           cmp.config.compare.offset,
--           cmp.config.compare.exact,
--           cmp.config.compare.score,
--           cmp.config.compare.recently_used,
--           require('cmp-under-comparator').under,
--           cmp.config.compare.kind,
--         },
--       },
--
--       enabled = function()
--         return vim.api.nvim_get_option_value('buftype', {}) ~= 'prompt' or require('cmp_dap').is_dap_buffer()
--       end,
--       cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
--         sources = {
--           { name = 'dap' },
--         },
--       }),
--     }
--   end,
-- }

-- TODO: handle dap and git like I did
return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = { preset = 'default', ['<C-l>'] = { 'snippet_forward', 'fallback' }, ['<C-h>'] = { 'snippet_backward', 'fallback' } },
    completion = {
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= 'cmdline'
        end,
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
    -- TODO: add signiture support today I use <C-K> from lsp
    -- signature = { enabled = true },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { 'sources.default' },
}
