adwaita = {
    'Mofiqul/adwaita.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.adwaita_darker = false -- for darker version
        vim.g.adwaita_disable_cursorline = true -- to disable cursorline
        vim.g.adwaita_transparent = true -- makes the background transparent
        vim.cmd 'colorscheme adwaita'
        if vim.g.adwaita_transparent then
            require('notify').setup {
                background_colour = '#000000',
            }
        end
    end,
}
bamboo = {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        local bamboo = require 'bamboo'
        bamboo.setup()
        bamboo.load()
    end,
}
mellifluous = {
    'ramojus/mellifluous.nvim',
    config = function()
        require('mellifluous').setup {} -- optional, see configuration section.
        vim.cmd 'colorscheme mellifluous'
    end,
}

flexoki = {
    'kepano/flexoki-neovim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd 'colorscheme flexoki'
    end,
}
everforest = {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
        require('everforest').setup {
            -- Your config here
            background = 'hard',
        }
        vim.cmd 'colorscheme everforest'
    end,
}

return { everforest }
