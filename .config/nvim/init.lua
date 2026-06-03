---@diagnostic disable: undefined-global

vim.g.mapleader = ' '
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.textwidth = 120
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
vim.opt.winborder = 'none'

vim.pack.add({
    { src = 'https://github.com/windwp/nvim-autopairs' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/brenoprata10/nvim-highlight-colors' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
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
    { src = 'https://github.com/folke/zen-mode.nvim' },
    { src = 'https://github.com/epwalsh/obsidian.nvim' },
    { src = 'https://github.com/christoomey/vim-tmux-navigator' },
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        version = 'main',
        build = ':TSUpdate',
    },
    {
        src = 'https://github.com/ThePrimeagen/harpoon',
        version = 'harpoon2',
        build = ':TSUpdate',
    }
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = "markdown",
    callback = function()
        vim.opt.textwidth = 120
    end
})

vim.cmd('packadd nvim.undotree')
vim.keymap.set('n', '<leader>u', require('undotree').open)


local function treesitter_install()
    local ensure_installed = { 'c', 'cpp', 'lua', 'php', 'javascript', 'html', 'css', 'tsx', 'typescript', 'go',
        'markdown', 'python' }
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
        ['<C-f>'] = cmp.mapping.scroll_docs(5),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-5),
    }),

    window = {
        completion = cmp.config.window.bordered({
            border = 'single',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
            -- Cap the menu width tightly
            max_width = 50,
        }),

        documentation = cmp.config.window.bordered({
            border = 'single',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,Search:None',
            -- This setting forces the doc window below or above the list
            -- instead of shoving it to the far left when space is tight
            col_offset = 0,
            side_padding = 0,
            max_width = 50,
            max_height = 10,
        }),
    },

    formatting = {
        fields = { 'abbr', 'kind' },
        format = function(entry, vim_item)
            if string.len(vim_item.abbr) > 50 then
                vim_item.abbr = string.sub(vim_item.abbr, 1, 50 - 3) .. '…'
            end
            return vim_item
        end,
    },

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

local orig_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}

    opts.border = 'single'

    opts.winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,Search:None'

    opts.max_width = 65
    opts.max_height = 12

    opts.wrap = false

    return orig_open_floating_preview(contents, syntax, opts, ...)
end

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

require('telescope').setup({
    defaults = {
        preview = { treesitter = true },
        color_devicons = true,
        file_ignore_patterns = { '4 Archive/', '^%.git/' },
    },
})
require('telescope').load_extension('ui-select')

require('luasnip').setup({ enable_autosnippets = true })
require('luasnip.loaders.from_vscode').lazy_load()

require('nvim-highlight-colors').setup({})

require('conform').setup({
    formatters_by_ft = {
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        c = { 'clang-format', stop_after_first = true },
    },
})

require('zen-mode').setup({
    window = {
        backdrop = 1,               -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 80,                 -- width of the Zen window
        height = 1,                 -- height of the Zen window
        options = {
            signcolumn = 'no',      -- disable signcolumn
            number = false,         -- disable number column
            relativenumber = false, -- disable relative numbers
            cursorline = false,     -- disable cursorline
            cursorcolumn = false,   -- disable cursor column
            foldcolumn = '0',       -- disable fold column
            list = false,           -- disable whitespace characters
        },
    },
})

require('obsidian').setup({
    workspaces = {
        {
            name = 'notes',
            path = '~/dox/notes',
        },
    },

    disable_frontmatter = true,

    follow_url_func = function(url)
        vim.fn.jobstart({ 'xdg-open', url }) -- linux
    end,

    ui = {
        enable = true,          -- set to false to disable all additional syntax features
        update_debounce = 200,  -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        checkboxes = {
            [' '] = { char = '', hl_group = 'ObsidianTodo' },
            ['x'] = { char = '', hl_group = 'ObsidianDone' },
            ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
            ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
            ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        },
        bullets = { char = '', hl_group = 'ObsidianBullet' },
        external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
        reference_text = { hl_group = 'ObsidianRefText' },
        highlight_text = { hl_group = 'ObsidianHighlightText' },
        tags = { hl_group = 'ObsidianTag' },
        block_ids = { hl_group = 'ObsidianBlockID' },
        hl_groups = {
            ObsidianTodo = { bold = true, fg = '#d65d0e' },
            ObsidianDone = { bold = true, fg = '#458588' },
            ObsidianRightArrow = { bold = true, fg = '#d65d0e' },
            ObsidianTilde = { bold = true, fg = '#cc241d' },
            ObsidianImportant = { bold = true, fg = '#fb4934' },
            ObsidianBullet = { bold = true, fg = '#458588' },
            ObsidianRefText = { underline = true, fg = '#b16286' },
            ObsidianExtLinkIcon = { fg = '#b16286' },
            ObsidianTag = { italic = true, fg = '#83a598' },
            ObsidianBlockID = { italic = true, fg = '#83a598' },
            ObsidianHighlightText = { bg = '#d79921' },
        },
    },
})

local harpoon = require('harpoon')
harpoon:setup()

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<leader>e', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
    end)
end

vim.keymap.set('n', '<leader>f', '<cmd>Oil --float<CR>')
vim.keymap.set('n', '<leader>m', vim.cmd.Mason)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>bp', '<cmd>bprev<CR>', {})
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>', {})
vim.keymap.set('n', '<C-h>', '<cmd><C-U>TmuxNavigateLeft<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<cmd><C-U>TmuxNavigateDown<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<cmd><C-U>TmuxNavigateUp<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<cmd><C-U>TmuxNavigateRight<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-q>', '<C-w>q', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'Y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>R', '<cmd>w<CR><cmd>restart<CR>',
    { desc = 'write and restart', silent = true, noremap = true })
vim.keymap.set('n', '<leader>cc', '<cmd>nohlsearch<CR>',
    { desc = 'Clear search highlights', silent = true, noremap = true })
vim.keymap.set('n', '<leader>Z', '<cmd>ZenMode<CR>', { desc = 'toggle ZenMode', silent = true, noremap = true })
vim.keymap.set('n', 'q:', '<Nop>')
vim.keymap.set('n', '<leader>gf', function() require('conform').format({ async = true, lsp_fallback = true }) end,
    { desc = 'Format buffer' })
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
vim.keymap.set('n', '<leader>F', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>gr', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>h', require('telescope.builtin').help_tags, {})
