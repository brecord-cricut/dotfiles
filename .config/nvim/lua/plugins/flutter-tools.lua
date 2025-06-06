return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  enabled = vim.fn.executable("flutter"),
  opts = {
    debugger = { enabled = true },
    default_run_args = {
      flutter = "-d macos",
      dart = "-d macos",
    },
    lsp = {
      settings = {
        lineLength = 120,
        enableSnippets = false,
        organiseImports = "explicit",
      },
    },
    root_patterns = { ".git" },
  },
}
