return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      bashls = { filetypes = { "sh", "zsh" } },
    },
  },
  keys = function()
    local lsp_clients_popup = require("custom.lsp").lsp_clients_popup

    return {
      { "<Leader>cL", lsp_clients_popup, desc = "Show Client" },
    }
  end,
}
