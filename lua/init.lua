local M = {}

-- Run a Terraform command in a terminal split
local function run_terraform_command(command)
  -- Open a horizontal split and resize it
  vim.cmd("split")
  vim.cmd("resize 15")

  -- Create a new terminal buffer
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.fn.termopen(command, {
    on_exit = function(_, code, _)
      local msg = (code == 0) and (command .. " completed successfully.") or (command .. " failed.")
      -- Append a message to the terminal buffer upon command completion
      vim.api.nvim_buf_set_lines(term_buf, -1, -1, false, { msg })
    end,
  })

  -- Set the terminal buffer to the new split
  vim.api.nvim_win_set_buf(0, term_buf)

  -- Make the buffer unlisted so it doesn’t clutter buffer lists
  vim.api.nvim_buf_set_option(term_buf, "buflisted", false)
end

-- Terraform commands
M.plan = function() run_terraform_command("terraform plan") end
M.init = function() run_terraform_command("terraform init") end
M.apply = function() run_terraform_command("terraform apply") end
M.apply_auto_approve = function() run_terraform_command("terraform apply -auto-approve") end

return M
