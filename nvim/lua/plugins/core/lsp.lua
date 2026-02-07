return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "lua_ls",
      "bashls",
      "clangd",
      "yamlls",
      "sqlls",
      "pyright",
      "tailwindcss",
      "html",
      "ts_ls",
      "cssls",
    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
