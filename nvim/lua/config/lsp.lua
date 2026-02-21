-- -- custom
-- vim.lsp.enable("bashls")
-- vim.lsp.enable("lua_ls")
--
-- -- lspconfig default (:h lspconfig-all)
-- vim.lsp.enable("asm_lsp") -- cargo install asm-lsp
-- vim.lsp.enable("rust-analyzer")
-- vim.lsp.enable("clangd")
-- vim.lsp.enable("angularls")
-- vim.lsp.enable("arduino_language_server") -- go install github.com/arduino/arduino-language-server@latest

vim.lsp.inlay_hint.enable(true)

vim.lsp.enable("gdscript")
vim.lsp.enable("postgres_lsp")
vim.lsp.enable("sqlls")

vim.lsp.config("asm_lsp", {
  filetypes = { 'asm', 's' },
})
