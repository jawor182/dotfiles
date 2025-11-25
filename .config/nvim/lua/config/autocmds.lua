local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("VimEnter", {
    group = augroup("autoupdate", { clear = true }),
    callback = function()
        require("lazy").update({ show = false })
    end,
})

autocmd("FileType", {
    pattern = { "markdown", "vimwiki" },
    callback = function()
        vim.keymap.set("n", "j", "gj", { silent = true, noremap = true })
        vim.keymap.set("n", "k", "gk", { silent = true, noremap = true })
        vim.opt.wrap = true
        vim.opt.linebreak = true
        vim.opt.breakindent = true
        vim.opt.formatoptions:append('t')
    end,
})

autocmd("FileType", {
    pattern = { "c","go","c++","nix" },
    callback = function ()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
    end
})
