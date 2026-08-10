---@diagnostic disable: undefined-global
require("full-border"):setup({
    -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
    type = ui.Border.PLAIN,
})
-- function Status:size()
-- end
Header.cwd = function() return ui.Line("") end
function Header:title()
    return ""
end

