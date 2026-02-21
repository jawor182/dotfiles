return {
	{
		"nvim-telescope/telescope.nvim",

		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
                defaults = {
                    file_ignore_patterns = { "4 Archive/", "^.git/"}
                }
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
