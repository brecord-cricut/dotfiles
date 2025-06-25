return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      bashls = { filetypes = { "sh", "zsh" } },
    },
  },
}
