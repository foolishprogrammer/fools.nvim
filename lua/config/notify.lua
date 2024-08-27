return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
        'hrsh7th/nvim-cmp',
    },
    config = function()
        require('notify').setup {
            background_colour = '#000000',
        }
        require('noice').setup {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
            cmdline = {
                enabled = true,
                view = 'cmdline',
            },
            vim.keymap.set(
                'n',
                '<leader>nh',
                ':Telescope notify theme=dropdown<CR>',
                { desc = '[N]otification [H]istory' }
            ),
        }
    end,
}
