-- Highlighting for tokens like `public`, `private`, and `const`
vim.api.nvim_set_hl(0, "@type.qualifier", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@storageclass", { link = "@keyword" })

-- clangd generates an enormous amount of logs:
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)
