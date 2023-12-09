local M = {}

M.current = {
    client_args = "--color always --render",
    window = {
        height = 0.8,
        width = 0.8,
        border = "single",
    },
}

function M.override_tbl(opts)
    if opts then
        M.current = vim.tbl_deep_extend("force", M.current, opts)
    end
end

return M
