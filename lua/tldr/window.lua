local M = {}

local function win_nmap(buf, lhs, rhs)
    vim.api.nvim_buf_set_keymap(buf, "n", lhs, rhs, {noremap = true, silent = true})
end

-- Create a new floating window.
function M.new()
    local ui = vim.api.nvim_list_uis()[1]

    local wincfg = {
        relative = "editor",
        style = "minimal",
        width = 150,
        height = 40,
        row = ui.height / 2 - 20,
        col = ui.width / 2 - 75,
        focusable = true,
        border = "single",
    }

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "filetype", "tldr")
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

    local win = vim.api.nvim_open_win(buf, true, wincfg)

    win_nmap(buf, "q", "<cmd>lua vim.api.nvim_win_close(".. win ..", true)<cr>")
    win_nmap(buf, "<Esc>", "<cmd>lua vim.api.nvim_win_close(".. win ..", true)<cr>")

    return buf
end

return M
