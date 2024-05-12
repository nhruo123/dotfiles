return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    opts = {},
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>ja',
        function()
          require('harpoon'):list():add()
        end,
        desc = '[J]ump list [A]dd',
      },
      {
        '<leader>jn',
        function()
          require('harpoon'):list():next()
        end,
        desc = '[J]ump list [N]ext',
      },
      {
        '<leader>jp',
        function()
          require('harpoon'):list():prev()
        end,
        desc = '[J]ump list [P]rev',
      },
      {
        '<leader>jr',
        function()
          require('harpoon'):list():remove()
        end,
        desc = '[J]ump list [R]emove',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Harpoon select 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Harpoon select 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Harpoon select 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Harpoon select 4',
      },
      {
        '<leader>5',
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'Harpoon select 5',
      },

      {
        '<leader>jl',
        function()
          require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
        end,
        desc = '[J]ump [L]ist',
      },
    },
  },
}
