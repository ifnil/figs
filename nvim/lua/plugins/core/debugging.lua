return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = "mfussenegger/nvim-dap",
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },

        delve = {
          path = "dlv"
        }
      })

      -- configure ui
      local dapui = require("dapui")
      dapui.setup()
    end,
  },
}
