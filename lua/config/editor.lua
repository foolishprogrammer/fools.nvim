return {
    {
        'nvimdev/indentmini.nvim',
        opts = {},
        config = function()
            require('indentmini').setup()
        end,
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        opts = {
            presets = {
                bottom_search = true,
                long_message_to_split = true,
            },
            cmdline = {
                enabled = true,
                view = 'cmdline',
            },
            vim.keymap.set('n', '<leader>nh', ':Telescope notify theme=dropdown<CR>', { desc = 'Notify : History' }),
        },
    },
}
