return {
    {
        'synaptiko/xit.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        ft = 'xit',
        opts = {
            disable_default_mappings = true,
        },
        config = function()
            -- local augroup = vim.api.nvim_create_augroup('xit_highlights_mappings', { clear = true })
            local xit = require 'xit'
            xit.setup()
            vim.keymap.set('n', 'ta', xit.create_new_task, { desc = '[T]ask [A]dd' })
            vim.keymap.set('n', 'tt', xit.toggle_checkbox, { desc = '[T]ask [T]oggle' })
            vim.keymap.set('n', 't]', xit.jump_to_next_task, { desc = '[T]ask Next (])' })
            vim.keymap.set('n', 't[', xit.jump_to_previous_task, { desc = '[T]ask Prev ([)' })
            vim.keymap.set('n', 'tha', xit.create_new_headline, { desc = '[T]ask [H]eadline [A]dd' })
            vim.keymap.set('n', 'th]', xit.jump_to_next_headline, { desc = '[T]ask [H]eadline Next(])' })
            vim.keymap.set('n', 'th[', xit.jump_to_previous_headline, { desc = '[T]ask [H]eadline Prev([)' })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
    },
}
