return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            debug = true,
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.completion.spell,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.diagnostics.sqlfluff,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.pint,
                null_ls.builtins.formatting.phpcbf,
                null_ls.builtins.diagnostics.phpstan,
                -- null_ls.builtins.diagnostics.glint,
                null_ls.builtins.diagnostics.phpcs,
                -- null_ls.builtins.diagnostics.jsonlint,
                -- null_ls.builtins.diagnostics.cpplint,
                -- null_ls.builtins.diagnostics.htmlhint,
                -- null_ls.builtins.diagnostics.shellcheck,
                -- null_ls.builtins.diagnostics.glint,
                null_ls.builtins.formatting.markdownlint,
                -- null_ls.builtins.formatting.beautysh,
                null_ls.builtins.formatting.pint,
                null_ls.builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "sqlite" },
                }),
            },
        })
    end,
}
