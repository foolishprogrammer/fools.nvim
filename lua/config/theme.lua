return {
    {
        'ribru17/bamboo.nvim',
        lazy = false,
        -- priority = 1000,
        -- config = function()
        --     local bamboo = require 'bamboo'
        --     bamboo.setup()
        --     bamboo.load()
        -- end,
    },
    {
        'Mofiqul/adwaita.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.adwaita_darker = false -- for darker version
            vim.g.adwaita_disable_cursorline = true -- to disable cursorline
            vim.g.adwaita_transparent = false -- makes the background transparent
            vim.cmd 'colorscheme adwaita'
            if vim.g.adwaita_transparent then
                require('notify').setup {
                    background_colour = '#000000',
                }
            end
        end,
    },
}
