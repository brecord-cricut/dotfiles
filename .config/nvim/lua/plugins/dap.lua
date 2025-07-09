return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  opts = function()
    local dap = require("dap")
    dap.adapters = {
      lldb = require("plugins.dap.lldb"),
      python = require("plugins.dap.python"),
    }
  end,

  keys = function()
    local dap = require("dap")
    local widgets = require("dap.ui.widgets")
    local continue = dap.continue
    local reset_ui = function()
      require("dapui").open({ reset = true })
    end
    local run_to_cursor = dap.run_to_cursor
    local step_into = dap.step_into
    local step_out = dap.step_out
    local step_over = dap.step_over
    local terminate = dap.terminate
    local toggle_breakpoint = dap.toggle_breakpoint
    local hover = widgets.hover
    local preview = widgets.preview
    local cf_frames = function()
      widgets.centered_float(widgets.frames)
    end
    local cf_scopes = function()
      widgets.centered_float(widgets.scopes)
    end
    return {
      { "<Leader>db", toggle_breakpoint, desc = "Dap Toggle Breakpoint" },
      { "<Leader>dc", continue, desc = "Dap Continue" },
      { "<Leader>dC", run_to_cursor, desc = "Dap Run to Cursor" },
      { "<Leader>df", cf_frames, desc = "Dap Frames" },
      { "<Leader>dh", hover, desc = "Dap Hover", mode = { "n", "v" } },
      { "<Leader>dp", hover, desc = "Dap Preview", mode = { "n", "v" } },
      { "<Leader>dp", hover, desc = "Dap Preview", mode = { "n", "v" } },
      { "<Leader>ds", cf_scopes, desc = "Dap Scopes" },
      { "<Leader>dt", terminate, desc = "Dap Terminate" },
      { "<Leader>dU", reset_ui, desc = "Dap UI Reset" },
      { "<F5>", continue, desc = "Dap Continue" },
      { "<F10>", step_over, desc = "Dap Step Over" },
      { "<F12>", step_out, desc = "Dap Step Out" },
      { "<F11>", step_into, desc = "Dap Step Into" },
    }
  end,
}
