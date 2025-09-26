return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        opts = {},
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup()
            statusline.section_fileinfo = function(args)
                return require('nvim-navic').get_location()
            end
            -- statusline.section_filename = function()
            --     return require('nvim-navic').get_location()
            -- end
            local pairs = require 'mini.pairs'
            pairs.setup()

            local surround = require 'mini.surround'
            surround.setup()
        end,
    },
}
