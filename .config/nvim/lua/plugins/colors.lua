return {
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup({
    --             flavor = "mocha",
    --             background = {
    --                 dark = "mocha",
    --             },
    --             transparent_background = true,
    --             show_end_of_buffer = true,
    --             term_colors = true,
    --             dim_inactive = {
    --                 enabled = false,
    --                 shade = "dark",
    --                 percentage = 0.15,
    --             },
    --             no_italic = false,
    --             no_bold = false,
    --             no_underline = false,
    --             styles = {
    --                 comments = { "italic" },
    --                 conditionals = { "italic" },
    --                 loops = {},
    --                 functions = {},
    --                 keywords = {},
    --                 strings = {},
    --                 variables = {},
    --                 numbers = {},
    --                 booleans = {},
    --                 properties = {},
    --                 types = {},
    --                 operators = {},
    --             },
    --             color_overrides = {},
    --             custom_highlights = {},
    --             default_integrations = true,
    --             integrations = {
    --                 cmp = true,
    --                 gitsigns = true,
    --                 nvimtree = false,
    --                 treesitter = true,
    --                 notify = false,
    --                 lualine = false,
    --                 mini = {
    --                     enabled = true,
    --                     indentscope_color = "",
    --                 },
    --             },
    --         })
    --
    --         vim.cmd("colorscheme catppuccin")
    --     end,
    -- },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true,
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = true,
                    operators = false,
                    folds = false,
                },
                -- italic = {
                --     strings = true,
                --     emphasis = true,
                --     comments = true,
                --     operators = true,
                --     folds = true,
                -- },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = false, -- invert background for search, diffs, statuslines and errors
                contrast = "hard", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = true,
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
}
