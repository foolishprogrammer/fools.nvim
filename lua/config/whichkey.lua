return {
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        config = function()
            require('which-key').setup()

            require('which-key').add {
                { '<leader>g', group = 'Git' },
                { '<leader>b', group = 'Buffer' },
                { '<leader>f', group = 'File' },
                { '<leader>h', group = 'Help' },
                { '<leader>l', group = 'LSP' },
                { '<leader>c', group = 'Code' },
                { '<leader>d', group = 'Debug' },
                { '<leader>n', group = 'Notify' },
                { '<leader>m', group = 'Mark' },
                { '<leader>cs', group = 'Code : Snippet' },
                { '<leader>ld', group = 'LSP : Documentation' },
                { '<leader>ls', group = 'LSP : Symbols' },
            }
        end,
    },
}
