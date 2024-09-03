return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
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
}
