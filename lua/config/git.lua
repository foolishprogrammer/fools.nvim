return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
            },
        },
        on_attach = function()
            local gitsigns = require 'gitsigns'
            vim.keymap.set('n', '<leader>gb', function()
                return gitsigns.blame_line { full = true }
            end, { desc = 'GIT : Blame' })
        end,
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
        event = 'VimEnter',
        dependecies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local telescope_builtin = require 'telescope.builtin'
            require('telescope').load_extension 'lazygit'

            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { desc = 'GIT : ' .. desc })
            end
            map('<leader>gg', ':LazyGit<CR>', 'LazyGit')
            map('<leader>gf', ':LazyGitFilterCurrentFile<CR>', 'Filter (Buf)')
            map('<leader>gF', ':LazyGitFilter<CR>', 'Filter (Root)')
            map('<leader>gc', telescope_builtin.git_bcommits, 'Commits (Buf)')
            map('<leader>gC', telescope_builtin.git_commits, 'Commits (Root)')
            map('<leader>ge', telescope_builtin.git_files, 'Explorer')
            map('<leader>gs', telescope_builtin.git_status, 'Status')
        end,
    },
}
