require('lazy').setup {
    spec = {
        { import = 'config' },
        { import = 'custom' },
        'tpope/vim-sleuth',
        { 'numToStr/Comment.nvim', opts = {} },
    },
}
