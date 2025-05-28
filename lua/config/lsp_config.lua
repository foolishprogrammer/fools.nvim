return {
    {
        'neovim/nvim-lspconfig',
        event = 'VimEnter',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            -- 'nvim-telescope/telescope.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'SmiteshP/nvim-navic',
            { 'j-hui/fidget.nvim', opts = {} },
        },

        config = function()
            -- local cmp = require('cmp')
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),
                callback = function(event)
                    local navic = require 'nvim-navic'
                    local buffer = event.buf
                    local builtin = require 'telescope.builtin'
                    -- local telescope_patch = require '_patches.telescope'
                    -- builtin.lsp_dynamic_workspace_symbols = telescope_patch
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end
                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, buffer)
                        map('<leader>lsw', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
                        map('<leader>lsd', builtin.lsp_document_symbols, 'Document Symbols')
                    end

                    map('<leader>ldd', builtin.lsp_type_definitions, 'Symbol Definitions')
                    map('<leader>ldk', vim.lsp.buf.hover, 'Hover Documentations')
                    map('<leader>lgd', vim.lsp.buf.definition, 'Find Definition')
                    map('<leader>lgD', vim.lsp.buf.declaration, 'Find Declaration')
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHiglightProvider then
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
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
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            table.unpack = table.unpack or unpack

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    '${3rd}/luv/library',
                                    table.unpack(vim.api.nvim_get_runtime_file('', true)),
                                },
                            },
                            completion = {
                                callSnippet = 'Replace',
                            },
                            diagnostics = { global = { 'vim' } },
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
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require('mason-lspconfig').setup {
                ensure_installed = {},
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
    {
        'L3MON4D3/LuaSnip',
        dependecies = {
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
        },
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        config = function()
            local cmp = require 'cmp'
            require('luasnip.loaders.from_vscode').lazy_load()
            local luasnip = require 'luasnip'
            luasnip.config.setup {}
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },
                mapping = cmp.mapping.preset.insert {
                    -- Select the next item
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Select the previous item
                    ['<C-p>'] = cmp.mapping.select_prev_item(),

                    ['<C-y>'] = cmp.mapping.confirm { select = true },

                    ['<C-Space>'] = cmp.mapping.complete {},

                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            }
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {
            stop_after_first = true,
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'isort', 'black' },
                javascript = { 'prettierd', 'prettier' },
            },
        },
    },
}
