local config = require("tldr.config")
local window = require("tldr.window")

local M = {}

local function err(msg)
    vim.notify("error: " .. msg, vim.log.levels.ERROR)
end

-- Render the current file using a tldr client and show the output in a floating window.
function M.render()
    local page_path = vim.api.nvim_buf_get_name(0)
    if page_path == "" then
        err("unnamed buffer!")
        return
    end

    if vim.fn.executable("tldr") == 0 then
        err("tldr not on $PATH. Please install a tldr client!")
        return
    end

    local client = vim.fn.exepath("tldr")
    local client_args = config.current.client_args

    local page = vim.fn.system(client .. " " .. client_args .. " " .. page_path)

    local buf = window.new()
    local term = vim.api.nvim_open_term(buf, {})
    vim.api.nvim_chan_send(term, page)
end

return M
