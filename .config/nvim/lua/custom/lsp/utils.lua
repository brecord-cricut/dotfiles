local M = {}

function M.lsp_clients_popup()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if vim.tbl_isempty(clients) then
    vim.notify("No LSP clients attached to this buffer.", vim.log.levels.INFO)
    return
  end

  local Popup = require("nui.popup")
  local event = require("nui.utils.autocmd").event
  local lines = vim.split(vim.inspect(clients), "\n", { plain = true })

  local popup = Popup({
    border = {
      style = "rounded",
      text = {
        top = "LSP Clients",
        top_align = "center",
      },
    },
    enter = true,
    focusable = true,
    position = "50%",
    size = "80%",
  })
  popup:mount()
  popup:on(event.BufLeave, function()
    popup:unmount()
  end)

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)
  vim.bo[popup.bufnr].filetype = "lua"
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].readonly = true
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(popup.winid, false)
  end, { buffer = popup.bufnr })
end

return M
