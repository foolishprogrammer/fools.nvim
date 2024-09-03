return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-telescope/telescope-file-browser.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
            pcall(require('telescope').load_extension, 'live_grep_args')
            pcall(require('telescope').load_extension, 'file_browser')

            local builtin = require 'telescope.builtin'
            local telescope = require 'telescope'

            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { desc = 'Telescope : ' .. desc })
            end
            map('<leader><leader>', builtin.buffers, '[ ] Buffer List')
            map('<leader>fe', function()
                return telescope.extensions.file_browser.file_browser { path = '%:p:h', select_buffer = true }
            end, 'File Browser')
            map('<leader>fE', telescope.extensions.file_browser.file_browser, 'File Browser (root)')
            map('<leader>fs', builtin.find_files, 'File Search')
            map('<leader>hs', builtin.help_tags, 'Help Search')
            map('<leader>fg', builtin.live_grep, 'Grep Search')
            map('<leader>fG', telescope.extensions.live_grep_args.live_grep_args, 'Grep Search')
            map('<leader>bd', builtin.diagnostics, 'Diagnostics Search')
            map('<leader>b/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Open Buffer Grep Search',
                }
            end, 'Buffer Grep Search')
        end,
    },
}
