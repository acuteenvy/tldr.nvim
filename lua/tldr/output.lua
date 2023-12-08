local Window = require("tldr.window")

local M = {}

-- Render the current file using a tldr client and show the output in a floating window.
function M.render()
    if vim.fn.executable("tldr") == 0 then
        vim.notify("error: tldr not on $PATH. Please install a tldr client!", vim.log.levels.ERROR)
        return
    end

    local client = vim.fn.exepath("tldr")
    local page_path = vim.api.nvim_buf_get_name(0)

    -- Line endings have to be changed: https://github.com/neovim/neovim/issues/14557
    local page = vim.fn.system(client .. " --color always --render " .. page_path):gsub("\n", "\r\n")
    local buf = Window.new()

    local term = vim.api.nvim_open_term(buf, {})
    vim.api.nvim_chan_send(term, page)
end

return M