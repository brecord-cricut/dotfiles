--[[
dflg.nvim - Dotfiles-aware LazyGit integration for LazyVim

This plugin overrides a keymap to open LazyGit with the correct --git-dir and --work-tree
options when editing files tracked in your dotfiles repository (managed with a bare git repo).
It automatically detects tracked directories and configures LazyGit accordingly.

Usage:
  require("custom.dflg").setup({
    git_dir = "~/.dotfiles",    -- Path to bare git directory
  })

Dependencies:
  - LazyVim (for Snacks.lazygit)
  - Neovim 0.10+
]]

--- @class DflgConfig
--- @field git_dir string Path to bare git directory
--- @field key string? Keymap to trigger LazyGit (default: "<leader>gg")
--- @field key_desc string? Label to show in Which-key (default: "Lazygit")
--- @field work_tree string? Path to work tree (default: "~")
local H = {
  git_dir = "",
  key = "<leader>gg",
  key_desc = "Lazygit",
  work_tree = vim.env.HOME,
}

--- Validates the configuration options passed to the plugin
--- @param opts table The configuration options to validate
--- @return boolean true if options are valid, false otherwise
local function validate_opts(opts)
  if type(opts) ~= "table" or vim.tbl_isempty(opts) then
    vim.notify("dflg: invalid options provided", vim.log.levels.ERROR)
    return false
  end
  if not opts.git_dir then
    vim.notify("dflg: invalid git_dir provided. Example: { git_dir = '$HOME/dotfiles' }", vim.log.levels.ERROR)
    return false
  end
  if vim.fn.isdirectory(opts.git_dir) == 0 then
    vim.notify("dflg: Dotfiles directory does not exist: " .. opts.git_dir, vim.log.levels.ERROR)
    return false
  end
  return true
end

--- Gets the current branch of the dotfiles repository
--- Uses git-dir and work-tree parameters to ensure correct repository access
--- @return string|nil The current branch name, or nil if command fails
local function get_branch()
  local git_dir = "--git-dir=" .. H.git_dir
  local work_tree = "--work-tree=" .. H.work_tree
  local cmd = vim.system({ "git", git_dir, work_tree, "rev-parse", "--abbrev-ref", "HEAD" }):wait()
  if cmd.code ~= 0 then
    vim.notify("dflg: Failed to get git-dir branch. Is this a git repository?", vim.log.levels.ERROR)
    return nil
  end
  local result, _ = cmd.stdout:gsub("%s+$", "")
  return result
end

--- Gets all tracked directories in the dotfiles repository for a given branch
--- @param branch string The branch name to check
--- @return table|nil List of tracked directory paths relative to work_tree, or nil if command fails
local function get_tracked_dirs(branch)
  local git_dir = "--git-dir=" .. H.git_dir
  local work_tree = "--work-tree=" .. H.work_tree
  local cmd = vim.system({ "git", git_dir, work_tree, "-C", H.work_tree, "ls-tree", "-dr", branch }):wait()
  if cmd.code ~= 0 then
    vim.notify(
      "dflg: Failed to get ls-tree. Is this a git repository? " .. cmd.stderr:gsub("%s+$", ""),
      vim.log.levels.ERROR
    )
    return nil
  end
  local dirs = {}
  for line in cmd.stdout:gmatch("[^\r\n]+") do
    local path = line:match("\t(.+)$")
    if path then
      table.insert(dirs, path)
    end
  end
  return dirs
end

--- Checks if a given buffer is within a tracked dotfiles directory
--- @param bufnr number|nil Buffer number to check (0 for current buffer)
--- @param tracked_dirs table List of directories tracked in dotfiles repository
--- @return boolean true if buffer is in a tracked directory, false otherwise
local function is_buf_in_dotfiles(bufnr, tracked_dirs)
  local buf_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr or 0), ":h")
  local rel = vim.fs.relpath(H.work_tree, buf_dir)
  for _, dir in ipairs(tracked_dirs) do
    if dir == rel then
      return true
    end
  end
  return false
end

return {
  --- Initializes the dflg.nvim plugin with the provided configuration
  --- Sets up keymaps and git directory tracking for dotfiles-aware LazyGit integration
  --- @param opts DflgConfig Configuration options for the plugin
  --- @return boolean|nil false if setup fails, nil otherwise
  setup = function(opts)
    if not validate_opts(opts) then
      return
    end
    H = vim.tbl_extend("force", H, opts)
    local branch = get_branch()
    if branch == nil then
      return false
    end
    local tracked_dirs = nil
    vim.schedule(function()
      tracked_dirs = get_tracked_dirs(branch)
    end)
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimKeymaps",
      once = true,
      callback = function()
        LazyVim.safe_keymap_set("n", H.key, function()
          if not tracked_dirs or #tracked_dirs == 0 then
            vim.notify("dflg: No tracked directories found in the dotfiles repository.", vim.log.levels.WARN)
            return
          end
          local lg_opts = {}
          if is_buf_in_dotfiles(0, tracked_dirs) then
            local git_dir = "--git-dir=" .. H.git_dir
            local work_tree = "--work-tree=" .. H.work_tree
            lg_opts.args = { git_dir, work_tree }
          end
          Snacks.lazygit.open(lg_opts)
        end, { desc = H.key_desc })
      end,
    })
  end,
}
