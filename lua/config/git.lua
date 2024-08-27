-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function()
                local gitsigns = require 'gitsigns'
                -- vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = '[G]it [B]lame' })
                vim.keymap.set('n', '<leader>gb', function()
                    gitsigns.blame_line { full = true }
                end, { desc = '[G]it [B]lame' })
            end,
        },
    },
    {
        'kdheepak/lazygit.nvim',
        cmd = {
            'LazyGit',
            'LazyGitConfig',
            'LazyGitCurrentFile',
            'LazyGitFilter',
            'LazyGitFilterCurrentFile',
        },
        -- optional for floating window border decoration
        event = 'VimEnter',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('telescope').load_extension 'lazygit'
            vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'Lazy[G]it' })
            vim.keymap.set('n', '<leader>gf', ':LazyGitFilterCurrentFile<CR>', { desc = '[G]it[F]ilter(buffer)' })
            vim.keymap.set('n', '<leader>gF', ':LazyGitFilter<CR>', { desc = '[G]it[F]ilter(root)' })
            vim.keymap.set('n', '<leader>gc', ':Telescope git_bcommits<CR>', { desc = '[G]it [C]ommits(buffer)' })
            vim.keymap.set('n', '<leader>gC', ':Telescope git_commits<CR>', { desc = '[G]it [C]ommits(root)' })
            vim.keymap.set('n', '<leader>gp', function()
                require('telescope').extensions.lazygit.lazygit()
            end, { desc = '[G]it [P]roject' })
        end,
    },
}
-- vim: ts=2 sts=2 sw=2 et
