return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'nvim-telescope/telescope.nvim',
            { 'j-hui/fidget.nvim', opts = {}},
        },

        config = function()
            -- local cmp = require('cmp')
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp_attach',{clear=true}),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, {buffer = event.buf, desc = 'LSP: ' .. desc})
                    end
                end,
            })
            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = 'css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact,xml',
                callback = function()
                    vim.lsp.start {
                        cmd = { 'emmet-language-server', '--stdio' },
                        root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
                        -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
                        -- **Note:** only the options listed in the table are supported.
                        init_options = {
                            ---@type table<string, string>
                            includeLanguages = {},
                            --- @type string[]
                            excludeLanguages = {},
                            --- @type string[]
                            extensionsPath = {},
                            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                            preferences = {},
                            --- @type boolean Defaults to `true`
                            showAbbreviationSuggestions = true,
                            --- @type "always" | "never" Defaults to `"always"`
                            showExpandedAbbreviation = 'always',
                            --- @type boolean Defaults to `false`
                            showSuggestionsAsSnippets = false,
                            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                            syntaxProfiles = {},
                            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                            variables = {},
                        },
                    }
                end,
            })
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = vim.tbl_deep_extend('force', capabiliities, require('cmp_nvim_lsp').default_capabilities())

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {version ='LuaJIT'},
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    '${3rd}/luv/library', unpack(vim.api.nvim_get_runtime_file('', true)),
                                },
                            },
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
            }
            require('mason').setup()
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua',
                'emmet-language-server',
            })
            require('mason-tool-installer').setup({ensure_installed = ensure_installed})

            require('mason-lspconfig').setup{
                handlers = {
                    function(server_name)
                        local server = servers['server_name'] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },
}
