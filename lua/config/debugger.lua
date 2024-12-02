return {

    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',
        },
        keys = function(_, keys)
            local dap = require 'dap'
            local dapui = require 'dapui'
            return {
                { '<F5>', dap.continue, desc = 'Start/Continue' },
                { '<F1>', dap.step_into, desc = 'Step Into' },
                { '<F2>', dap.step_over, desc = 'Step Over' },
                { '<F3>', dap.step_out, desc = 'Step Out' },
                { '<leader>db', dap.toggle_breakpoint, desc = 'Toggle Breakpoint' },
                { '<F7>', dapui.toggle, desc = 'Last Session Result' },
                unpack(keys),
            }
        end,
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'
            require('mason').setup()
            require('mason-nvim-dap').setup {
                automatic_installation = true,
                handlers = {},
                ensure_installed = {
                    'delve',
                },
            }
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

            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close
        end,
    },
}
