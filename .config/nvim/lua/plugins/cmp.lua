return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		-- Autocompletion
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",

		version = "*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- snippets = { preset = "luasnip" },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			fuzzy = {
				implementation = "rust",
			},

			cmdline = {
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					-- Dbee
					sql = { "dbee", "buffer" },
				},
				providers = {
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
					dbee = { name = "cmp-dbee", module = "blink.compat.source" },

					snippets = {
						opts = {
							friendly_snippets = true,
						},
					},
				},
			},

			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
				menu = {
					draw = {
						-- columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },

						-- look like cmp
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
			},

			keymap = {
				preset = "default",
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },

				["<C-space>"] = {
					function(cmp)
						cmp.show({ providers = { "snippets" } })
					end,
				},
				["<C-r>"] = {
					function(cmp)
						cmp.show()
					end,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			floating_window = false,
			hint_scheme = "Comment",
			hint_prefix = " ",
		},
	},
}
