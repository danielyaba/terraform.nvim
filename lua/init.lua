local M = {}

-- Highlight keywords
local function highlight_output(bufnr, line, keyword, hl_group)
  local start_pos, end_pos = string.find(line:lower(), keyword:lower())
  if start_pos and end_pos then
    vim.api.nvim_buf_add_highlight(bufnr, -1, hl_group, vim.api.nvim_buf_line_count(bufnr) - 2, start_pos - 1, end_pos)
  end
end

-- Run a Terraform command
local function run_terraform_command(command)
  vim.cmd("split")
  vim.cmd("resize 15")
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.fn.termopen(command, {
    on_stdout = function(_, data, _)
      for _, line in ipairs(data) do
        if line ~= "" then
          vim.api.nvim_buf_set_lines(term_buf, -1, -1, false, { line })
          highlight_output(term_buf, line, "warning", "WarningMsg")
          highlight_output(term_buf, line, "error", "ErrorMsg")
        end
      end
    end,
    on_exit = function(_, code, _)
      local msg = (code == 0) and (command .. " completed successfully.") or (command .. " failed.")
      vim.api.nvim_buf_set_lines(term_buf, -1, -1, false, { msg })
    end,
  })
  vim.api.nvim_buf_set_option(term_buf, "buflisted", false)
end

M.plan = function() run_terraform_command("terraform plan") end
M.init = function() run_terraform_command("terraform init") end
M.apply = function() run_terraform_command("terraform apply") end
M.apply_auto_approve = function() run_terraform_command("terraform apply -auto-approve") end

return M
