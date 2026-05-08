local dap = require("dap")
local dapui = require("dapui")
local mason_dap = require("mason-nvim-dap")

local function get_program()
	local buf = vim.fn.expand("%:p")
	if buf ~= "" and not buf:match("%[") and vim.fn.filereadable(buf) == 1 then
		return buf
	end
	return vim.fn.input("Path to file: ", vim.fn.getcwd() .. "/", "file")
end

-- Enable virtual text
require("nvim-dap-virtual-text").setup()

-- Configure Mason to install debuggers automatically
mason_dap.setup({
	ensure_installed = { "python", "cppdbg", "coreclr" },
	automatic_installation = true,
	handlers = {
		function(config)
			mason_dap.default_setup(config)
		end,
	},
})

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticHint" })
vim.fn.sign_define("DapLogPoint", { text = "◈", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })

-- JS/TS debug adapter (not supported by mason-nvim-dap default handler)
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Node: Launch file",
			program = get_program,
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Bun: Launch file",
			program = get_program,
			cwd = "${workspaceFolder}",
			runtimeExecutable = "bun",
			runtimeArgs = { "--inspect-brk" },
			console = "integratedTerminal",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Bun: Run script",
			program = get_program,
			cwd = "${workspaceFolder}",
			runtimeExecutable = "bun",
			runtimeArgs = { "run", "--inspect-brk" },
			console = "integratedTerminal",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to process (pid)",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Bun: Attach (port)",
			port = function()
				return tonumber(vim.fn.input("Inspector port [6499]: ", "6499"))
			end,
			cwd = "${workspaceFolder}",
		},
	}
end

-- Setup DAP UI
dapui.setup()

-- Auto-open/close DAP UI
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Keymaps
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
