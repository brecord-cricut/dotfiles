return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  enabled = vim.fn.executable("flutter"),
  opts = function()
    LazyVim.safe_keymap_set("n", "<Leader>dFd", "<cmd>FlutterDebug<cr>")
    LazyVim.safe_keymap_set("n", "<Leader>dFl", function()
      vim.cmd("FlutterLogToggle")
      -- Reset DAP UI, if its open:
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
        if filetype == "dapui_scopes" then
          require("dapui").open({ reset = true })
          break
        end
      end
    end, { desc = "FlutterLogToggle" })
    return {
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
      dev_log = {
        enabled = false,
        filter = nil,
      },
    }
  end,
}
