return {
    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for install instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                build = 'make',

                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            { 'nvim-tree/nvim-web-devicons' },
        },
        config = function()
            -- See `:help telescope` and `:help telescope.setup()`
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable telescope extensions, if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader>ge', builtin.git_files, { desc = '[G]it [E]xplorer' })
            vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
            vim.keymap.set('n', '<leader>ga', builtin.git_stash, { desc = '[G]it St[a]sh' })
            vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, { desc = '[G]it Commit [H]istory (buffer)' })
            vim.keymap.set('n', '<leader>gH', builtin.git_commits, { desc = '[G]it Commit [H]istory (root)' })
            vim.keymap.set('n', '<leader>uc', builtin.colorscheme, { desc = '[U]I [C]olorscheme' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            -- Also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            -- Shortcut for searching your neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            vim.keymap.set(
                'n',
                '<leader>fe',
                ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
                { desc = '[F]ile [E]xplorer (buffer)' }
            )
            vim.keymap.set('n', '<leader>fE', ':Telescope file_browser<CR>', { desc = '[F]ile [E]xplorer (root)' })
        end,
    },
    {
        'benfowler/telescope-luasnip.nvim',
        event = 'VimEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            require('telescope').load_extension 'luasnip'
            vim.keymap.set(
                'n',
                '<leader>csp',
                ':Telescope luasnip theme=dropdown<CR>',
                { desc = '[C]ode [S]nippet [P]review' }
            )
        end,
    },
}
