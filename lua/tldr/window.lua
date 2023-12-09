local config = require("tldr.config")

local M = {}

local function win_nmap(buf, lhs, rhs)
    vim.api.nvim_buf_set_keymap(buf, "n", lhs, rhs, { noremap = true, silent = true })
end

-- Create a new floating window.
function M.new()
    local overrides = {
        window = {
            relative = "editor",
            style = "minimal",
        },
    }

    if config.current.window.height <= 1 then
        local editor_height = vim.api.nvim_win_get_height(0)
        config.current.window.height = math.floor(editor_height * config.current.window.height)
    end

    if config.current.window.width <= 1 then
        local editor_width = vim.api.nvim_win_get_width(0)
        config.current.window.width = math.floor(editor_width * config.current.window.width)
    end

    -- Center the floating window.
    local ui = vim.api.nvim_list_uis()[1]
    overrides.window.row = ui.height / 2 - config.current.window.height / 2
    overrides.window.col = ui.width / 2 - config.current.window.width / 2

    config.override_tbl(overrides)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "filetype", "tldr")
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

    local win = vim.api.nvim_open_win(buf, true, config.current.window)

    win_nmap(buf, "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<cr>")
    win_nmap(buf, "<Esc>", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<cr>")

    return buf
end

return M
