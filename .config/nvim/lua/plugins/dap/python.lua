return function(cb, config)
  print(vim.inspect(config))
  local opts = {
    args = { "-m", "debugpy.adapter" },
  }
  local final = vim.tbl_extend("force", require("mason-nvim-dap.mappings.adapters.python"), opts)
  return vim.tbl_extend("force", require("mason-nvim-dap.mappings.adapters.python"), opts)
end
