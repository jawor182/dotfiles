---@diagnostic disable: undefined-global

vim.g.mapleader = ' '
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.smartindent = false
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.conceallevel = 2

vim.pack.add({
    { src = 'https://github.com/windwp/nvim-autopairs' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/brenoprata10/nvim-highlight-colors' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/kylechui/nvim-surround' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/williamboman/mason.nvim' },
    { src = 'https://github.com/williamboman/mason-lspconfig.nvim' },
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-buffer' },
    { src = 'https://github.com/hrsh7th/cmp-path' },
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
    { src = 'https://github.com/rafamadriz/friendly-snippets' },
    { src = 'https://github.com/honza/vim-snippets' },
    { src = 'https://github.com/j-hui/fidget.nvim' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        version = 'main',
        build = ':TSUpdate',
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c","cpp","go","nix", "markdown" },
    callback = function ()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
    end
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})

vim.cmd('packadd nvim.undotree')
vim.keymap.set('n', '<leader>u', require('undotree').open)


local function treesitter_install()
    local ensure_installed = { 'c', 'cpp', 'lua', 'php', 'javascript', 'html', 'css', 'tsx', 'typescript', 'go', 'markdown', 'python' }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim.iter(ensure_installed)
    :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()
    require('nvim-treesitter').install(parsersToInstall)
end
treesitter_install()

local function pack_clean()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print('No unused plugins.')
        return
    end

    local choice = vim.fn.confirm('Remove unused plugins?', '&Yes\n&No', 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end

vim.keymap.set('n', '<leader>pc', pack_clean)

require('nvim-autopairs').setup({})

local cmp = require('cmp')
local ls = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Enter>'] = cmp.mapping.confirm({ select = true }),
        ['<Enter>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),
})

require('mason').setup({
    ui = {
        icons = {
            package_installed = '',
            package_pending = '',
            package_uninstalled = '',
        },
    },
})

require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'gopls',
        'bashls',
        'clangd',
        'cssls',
        'cssmodules_ls',
        'css_variables',
        'emmet_language_server',
        'jsonls',
        'html',
        'pyright',
        'intelephense',
        'ts_ls',
        'tailwindcss',
        'yamlls',
        'marksman',
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })
        end,
    },
})

require('gruvbox').setup({
    italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
    },
    contrast = 'hard',
    transparent_mode = true,
    inverse = false,
    strikethrough = true,
})
vim.cmd.colorscheme('gruvbox')

require('lualine').setup({
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { '' },
        lualine_z = { 'progress' },
    },
})

require('oil').setup({
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
    },
    columns = {
        'icon',
    },
    float = {
        max_width = 0.5,
        max_height = 0.6,
        border = 'rounded',
    },
})

require('mini.pick').setup({
  window = {
    config = function()
      local height = math.floor(0.6 * vim.o.lines)
      local width = math.floor(0.6 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        border = 'rounded',
      }
    end,
  },
})

vim.ui.select = function(items, opts, on_choice)
  require('mini.pick').ui_select(items, opts, on_choice)
end
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

require('luasnip').setup({ enable_autosnippets = true })
require('luasnip.loaders.from_vscode').lazy_load()

require('nvim-highlight-colors').setup({})

require("conform").setup({
    formatters_by_ft = {
        markdown = { "prettierd", "prettier", stop_after_first = true },
    },
})

for i = 1, 8 do
    vim.keymap.set({ 'n', 't' }, '<Leader>' .. i, '<Cmd>tabnext ' .. i .. '<CR>')
end

vim.keymap.set('n', '<leader>f', "<cmd>Oil --float<CR>")
vim.keymap.set('n', '<leader>P', vim.cmd.bprev)
vim.keymap.set('n', '<leader>N', vim.cmd.bnext)
vim.keymap.set('n', '<leader>T', vim.cmd.tabnew)
vim.keymap.set('n', '<leader>tn', vim.cmd.tabnext)
vim.keymap.set('n', '<leader>tp', vim.cmd.tabprevious)
vim.keymap.set('n', '<leader>m', vim.cmd.Mason)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-q>', '<C-w>q', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'Y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>R', '<cmd>w<CR><cmd>restart<CR>', { desc = 'write and restart', silent = true, noremap = true })
vim.keymap.set('n', '<leader>cc', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights', silent = true, noremap = true })
vim.keymap.set('n', 'q:', '<Nop>')
vim.keymap.set('n', '<leader>gf', function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format buffer" })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>F', function() require('mini.pick').builtin.files({tool = "fd"}) end)
vim.keymap.set('n', '<leader>gr', function() require('mini.pick').builtin.grep_live() end)
vim.keymap.set('n', '<leader>h', function() require('mini.pick').builtin.help() end)
