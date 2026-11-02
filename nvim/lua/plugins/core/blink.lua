return {
	"saghen/blink.cmp",
	dependencies = { "saghen/blink.lib", "rafamadriz/friendly-snippets" },
	build = function()
		-- build the fuzzy matcher, wait up to 60 seconds
		-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
		require("blink.cmp").build():wait(60000)
	end,
	opts = {
		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
				["<Right>"] = false,
				["<Left>"] = false,
			},

			completion = {
				list = { selection = { preselect = false } },
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
					end,
				},
				ghost_text = { enabled = true },
			},
		},

		keymap = {
			preset = "enter",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets", "lsp" } })
				end,
			},
			["<C-y>"] = { "select_and_accept" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		signature = { enabled = false },

		completion = {
			documentation = { auto_show = true },
			ghost_text = { enabled = true },
			trigger = {
				prefetch_on_insert = false,
				show_on_backspace = true,
				show_on_backspace_in_keyword = true,
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "minuet" },
			providers = {
				minuet = {
					name = "minuet",
					module = "minuet.blink",
					async = true,
					-- Should match minuet.config.request_timeout * 1000,
					-- since minuet.config.request_timeout is in seconds
					timeout_ms = 3000,
					score_offset = 50, -- Gives minuet higher priority among suggestions
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
