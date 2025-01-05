# Terraform Neovim Plugin

A Terraform plugin for Neovim for running Terraform commands in a split pane

## Installation Using Lazy
```
{
  'danielyaba/terraform.nvim'
  config = function()
    local terraform = require("terraform_plugin")  
  end,
  keys = {
  -- Key mappings
    vim.api.nvim_set_keymap("n", "<leader>tfp", "<cmd>lua terraform_plugin.plan()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tfi", "<cmd>lua terraform_plugin.init()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tfa", "<cmd>lua terraform_plugin.apply()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tfaa", "<cmd>lua terraform_plugin.apply_auto_approve()<CR>", { noremap = true, silent = true })
  } 
}
```
