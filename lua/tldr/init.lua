--
-- tldr.nvim - Preview tldr pages in a floating window.
-- Requires a tldr client on '$PATH'.
-- https://github.com/acuteenvy/tldr.nvim
--

local M = {}

M.conf = {
    client_args = "--color always --render",
    window = {
        height = 0.8,
        width = 0.8,
    },
}

local function err(msg)
    vim.notify("(tldr.nvim) error: " .. msg, vim.log.levels.ERROR)
end

local function win_nmap(buf, lhs, rhs)
    vim.api.nvim_buf_set_keymap(buf, "n", lhs, rhs, { noremap = true, silent = true })
end

-- Create a new floating window.
local function new_win()
    local winconf = M.conf.window
    winconf.relative = "editor"
    winconf.style = "minimal"

    if winconf.height <= 1 then
        local editor_height = vim.api.nvim_win_get_height(0)
        winconf.height = math.floor(editor_height * winconf.height)
    end

    if winconf.width <= 1 then
        local editor_width = vim.api.nvim_win_get_width(0)
        winconf.width = math.floor(editor_width * winconf.width)
    end

    -- Center the floating window.
    local ui = vim.api.nvim_list_uis()[1]
    winconf.row = ui.height / 2 - winconf.height / 2
    winconf.col = ui.width / 2 - winconf.width / 2

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value("filetype", "tldr", { buf = buf })
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

    local win = vim.api.nvim_open_win(buf, true, winconf)

    win_nmap(buf, "q", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<cr>")
    win_nmap(buf, "<Esc>", "<cmd>lua vim.api.nvim_win_close(" .. win .. ", true)<cr>")

    return buf
end

-- Render the current file using a tldr client and show the output in a floating window.
function M.render_page()
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
    local client_args = M.conf.client_args

    local page = vim.fn.system(client .. " " .. client_args .. " " .. page_path)

    local buf = new_win()
    local term = vim.api.nvim_open_term(buf, {})
    vim.api.nvim_chan_send(term, page)
end

function M.setup(opts)
    vim.api.nvim_create_user_command("Tldr", M.render_page, {})
    if opts then
        M.conf = vim.tbl_deep_extend("force", M.conf, opts)
    end
end

return M
