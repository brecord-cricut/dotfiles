if vim.fn.executable("python") == 1 and vim.env.VIRTUAL_ENV == nil then
  vim.notify(
    "Python virtual environment not detected. Activate one (e.g., via `source venv/bin/activate`) before working on Python files.",
    vim.log.levels.ERROR
  )
end
