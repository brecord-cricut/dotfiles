return {
  config = function(_, opts)
    require("custom/dflg").setup({
      git_dir = vim.env.REPOS .. "/dotfiles",
    })
  end,
  dir = vim.fn.stdpath("config") .. "/lua/custom/dflg",
  event = "VeryLazy",
  name = "dflg",
}
