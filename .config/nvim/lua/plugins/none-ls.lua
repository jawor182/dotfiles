return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
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
                null_ls.builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "sqlite" }, -- change to your dialect
                }),
                null_ls.builtins.formatting.sqlfluff.with({
                    extra_args = { "--dialect", "sqlite" }, -- change to your dialect
                }),
            },
        })
    end,
}
