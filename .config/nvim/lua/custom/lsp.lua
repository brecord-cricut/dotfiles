local M = {}

function M.lsp_clients_popup()
  local function find_attached_client()
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
      for bufnr, _ in pairs(client.attached_buffers) do
        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
          return client
        end
      end
    end
    return {}
  end
  local attached_client = find_attached_client()
  if vim.tbl_isempty(attached_client) then
    vim.notify("No LSP clients attached to this buffer.", vim.log.levels.INFO)
    return
  end
  local status, Popup = pcall(require, "nui.popup")
  if not status then
    vim.notify("nui.nvim is required", vim.log.levels.ERROR)
    return
  end
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
  popup:on("BufLeave", function()
    popup:unmount()
  end)
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, true, vim.split(vim.inspect(attached_client), "\n", { plain = true }))
  vim.bo[popup.bufnr].bufhidden = "wipe"
  vim.bo[popup.bufnr].buftype = "nofile"
  vim.bo[popup.bufnr].filetype = "lua"
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].readonly = true
  vim.bo[popup.bufnr].swapfile = false
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(popup.winid, false)
  end, { buffer = popup.bufnr })
end

vim.api.nvim_create_user_command("LspClientsPopup", M.lsp_clients_popup, {})

return M
