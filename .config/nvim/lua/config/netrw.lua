vim.g.netrw_liststyle = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_chgperm = 1
vim.g.netrw_hide = 1
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

local function Path()
	-- local path = vim.fn.expand('%:~:.') -- Relative
	local path = vim.fn.expand("%:~") -- Absolute
	return "%#StatusLine# " .. path
end

WinBarNetRW = function()
	return table.concat({
		Path(),
		"%=",
		" NETRW ",
		"%<",
	})
end

vim.api.nvim_create_augroup("netrw", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "netrw",
	pattern = "netrw",
	callback = function()
		vim.api.nvim_command("setlocal buftype=nofile")
		vim.api.nvim_command("setlocal bufhidden=wipe")
		vim.opt_local.winbar = "%!v:lua.WinBarNetRW()"
        local opts = { remap = true, silent = true, buffer = true}
		vim.keymap.set("n", "<BS>", "-", opts)
		vim.keymap.set("n", "r", "R", opts )
        vim.keymap.set("n", "l", "<CR>", opts)
		vim.keymap.set("n", "h", "-", opts)
		vim.keymap.set("n", "<c-h>", "gh", opts)
        vim.keymap.set("n", "a", "%", opts)
        vim.keymap.set("n", "A", "d", opts)
		local unbinds = {
			"<F1>",
			"<del>",
			"<c-r>",
			"<c-tab>",
			"C",
			"gb",
			"gd",
			"gf",
			"gn",
			"gp",
			"i",
			"I",
			"mb",
			"mc",
			"md",
			"me",
			"mf",
			"mF",
			"mg",
			"mh",
			"mm",
			"mr",
			"mt",
			"mT",
			"mu",
			"mv",
			"mx",
			"mX",
			"mz",
			"o",
			"O",
			"p",
			"P",
			"qb",
			"qf",
			"qF",
			"qL",
			"s",
			"S",
			"t",
			"u",
			"U",
			"v",
			"x",
			"X",
		}
		for _, value in pairs(unbinds) do
			vim.keymap.set(
				"n",
				value,
				"<CMD>lua print(\"Keybind '" .. value .. "' has been removed\")<CR>",
				{ noremap = true, silent = true, buffer = true }
			)
		end
	end,
})
