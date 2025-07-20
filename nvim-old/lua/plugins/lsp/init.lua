return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim",        words = { "Snacks" } },
            },
        },
    },

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
        },
    },

    {
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "mason-org/mason-lspconfig.nvim",
                { "j-hui/fidget.nvim", opts = {} },

                -- Schema information
                "b0o/SchemaStore.nvim",
            },
            cmd = { "LspInfo", "LspInstall", "LspStart" },
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                    callback = function(event)
                        require("plugins.lsp.keymaps").lsp(event)
                    end,
                })

                local capabilities = require('blink.cmp').get_lsp_capabilities()

                local servers = require("plugins.lsp.servers")

                local server_names = vim.tbl_keys(servers or {})

                for server_name, _ in pairs(servers) do
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend(
                        'force',
                        {},
                        capabilities,
                        server.capabilities or {}
                    )
                    vim.lsp.config(server_name, server or {})
                end

                require("mason-lspconfig").setup {
                    ensure_installed = server_names,
                    automatic_enable = server_names,
                }
            end,
        },
    },


    -- format
    {
        "stevearc/conform.nvim",
        lazy = true,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    go = { "goimports", "gofmt" },
                    cs = { "csharpier" },
                    javascript = { "prettier", "eslint" },
                    typescript = { "prettier", "eslint" },
                    javascriptreact = { "prettier", "eslint" },
                    typescriptreact = { "prettier", "eslint" },
                    svelte = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    graphql = { "prettier" },
                    lua = { "stylua" },
                },
                formatters = {
                    csharpier = {
                        command = "csharpier",
                        args = { "format", "--write-stdout" },
                    },
                },
            })

            require("plugins.lsp.keymaps").format(conform)
        end,
    },
    {
        "Decodetalkers/csharpls-extended-lsp.nvim",
        config = function()
            require("csharpls_extended").buf_read_cmd_bind()
        end
    },

    -- lint
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                go = { "golangcilint" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<leader>ll", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
