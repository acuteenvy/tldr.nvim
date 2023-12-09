local config = require("tldr.config")

local M = {}

function M.setup(opts)
    vim.api.nvim_create_user_command("Tldr", require("tldr.output").render, {})
    config.override_tbl(opts)
end

return M
