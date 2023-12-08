local M = {}

function M.setup()
    vim.api.nvim_create_user_command("Tldr", require("tldr.output").render, {})
end

return M
