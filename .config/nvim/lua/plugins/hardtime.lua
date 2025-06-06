return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = function()
    local ht = require("hardtime")
    local function set(state)
      if state then
        ht.enable()
      else
        ht.disable()
      end
    end
    local function get()
      return ht.is_plugin_enabled
    end
    Snacks.toggle
      .new({
        id = "hardtime",
        name = "Hardtime",
        get = get,
        set = set,
      })
      :map("<leader>uH")
  end,
}
