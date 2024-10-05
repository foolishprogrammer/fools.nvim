return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        opts = {},
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup()
            statusline.section_filename = function()
                return require('nvim-navic').get_location()
            end
        end,
    },
}