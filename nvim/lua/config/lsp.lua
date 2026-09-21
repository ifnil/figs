vim.lsp.inlay_hint.enable(true)

vim.lsp.enable("gdscript")
vim.lsp.enable("postgres_lsp")
vim.lsp.enable("sqlls")
vim.lsp.enable("zls")
vim.lsp.enable("glsl_analyzer")
vim.lsp.enable("ocamlls")
vim.lsp.enable("asm_lsp")
vim.lsp.enable("elmls")

vim.lsp.config("gopls", {
  on_init = function(client)
    if client.config.init_options and client.config.init_options.semanticTokens then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
        range = true,
      }
    end
  end,
  settings = {
    gopls = {
      semanticTokens = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
  -- settings = {
  --   gopls = {
  --     hints = {
  --       assignVariableTypes = true,
  --       compositeLiteralFields = true,
  --       compositeLiteralTypes = true,
  --       constantValues = true,
  --       functionTypeParameters = true,
  --       parameterNames = true,
  --       rangeVariableTypes = true,
  --     },
  --   },
  -- },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

-- User commands
vim.api.nvim_create_user_command("InlayHintsToggle", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, {})

vim.api.nvim_create_user_command("InlayHintsEnable", function()
  vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
end, {})

vim.api.nvim_create_user_command("InlayHintsDisable", function()
  vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
end, {})
