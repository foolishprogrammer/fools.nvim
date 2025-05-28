return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'main',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { desc = 'Neotree : ' .. desc })
            end
            -- local command = require('neo-tree.command')
            map('<leader>ff', ':Neotree toggle<CR>', 'File Pane')
        end,
    },
    {
        'cbochs/grapple.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('telescope').load_extension 'grapple'
        end,
        opts = {
            scope = 'git', -- also try out "git_branch"
        },
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = 'Grapple',
        keys = {
            { '<leader>mm', '<cmd>Grapple toggle<cr>', desc = 'Mark : toggle tag' },
            { '<leader>me', '<cmd>Telescope grapple tags<cr>', desc = 'Mark : open tags window' },
            { '<leader>m]', '<cmd>Grapple cycle_tags next<cr>', desc = 'Mark : cycle next tag' },
            { '<leader>m[', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Mark : cycle previous tag' },
        },
    },
}
