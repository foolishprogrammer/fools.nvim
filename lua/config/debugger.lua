return {

    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',
        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'
            require('mason-nvim-dap').setup {
                automatic_setup = true,
                handlers = {},
                ensure_installed = {
                    'delve',
                },
            }
            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { desc = 'DAP : ' .. desc })
            end
            map('<F5>', dap.continue, 'Start/Continue')
            map('<F1>', dap.step_into, 'Step Into')
            map('<F2>', dap.step_over, 'Step Over')
            map('<F3>', dap.step_out, 'Step Out')
            map('<leader>db', dap.toggle_breakpoint, 'Toggle Breakpoint')

            dapui.setup {
                icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                controls = {
                    icons = {
                        pause = '⏸',
                        play = '▶',
                        step_into = '⏎',
                        step_over = '⏭',
                        step_out = '⏮',
                        step_back = 'b',
                        run_last = '▶▶',
                        terminate = '⏹',
                        disconnect = '⏏',
                    },
                },
            }
            map('<F7>', dapui.toggle, 'Last Session Result')

            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close
        end,
    },
}
