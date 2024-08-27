return {
    'willothy/wezterm.nvim',
    config = function()
        local wezterm = require 'wezterm'
        local right_pane = wezterm.SplitOpts
        right_pane = {
            right = true,
            percent = 35,
        }
        local left_pane = wezterm.SplitOpts
        left_pane = {
            left = true,
            percent = 35,
        }

        vim.keymap.set('n', '<leader>wpl', function()
            wezterm.split_pane.horizontal(right_pane)
        end, { desc = '[W]eztem [P]ane Right(L)' })
        vim.keymap.set('n', '<leader>wph', function()
            wezterm.split_pane.horizontal(left_pane)
        end, { desc = '[W]eztem [P]ane Left(H)' })
        vim.keymap.set('n', '<leader>w]', function()
            wezterm.switch_pane.direction 'Next'
        end, { desc = '[W]eztem Switch Next(])' })
        vim.keymap.set('n', '<leader>w[', function()
            wezterm.switch_pane.direction 'Prev'
        end, { desc = '[W]eztem Switch Next([)' })
    end,
}
