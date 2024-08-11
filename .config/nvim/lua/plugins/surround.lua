return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
            -- ysxy - surround a x with 
            -- $ X - in visual mode surround selected with X
            -- csxy - change surroundings from x to y
            -- dsx - remove x surroundings
            -- with t the same stuff work in html
            -- ysfw - wrap with function
            -- csf - change func name
            -- dsf - delete func name
        })
    end
}

