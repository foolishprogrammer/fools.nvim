return {
    {
        'xiyaowong/transparent.nvim',
        event = 'VimEnter',
        opts = {
            extra_groups = {
                'NormalFloat',
                'NvimTreeNormal',
            },
            -- exclude_groups = {
            --     'StatusLine',
            --     'StatusLineNC',
            -- },
        },
        config = function()
            vim.keymap.set('n', '<leader>ut', ':TransparentToggle<CR>', { desc = '[U]I [T]ransparency' })
        end,
    },
    {
        'rebelot/kanagawa.nvim',
        opts = {},
    },
    {
        'folke/tokyonight.nvim',
        opts = {},
    },
    {
        'ellisonleao/gruvbox.nvim',
        opts = {},
    },

    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd 'colorscheme nordic'
            require('nordic').load()
        end,
    },
}
