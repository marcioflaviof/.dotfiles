local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	return
end

colorizer.setup({
	-- filetypes = { "scss", "css", "lua", "typescriptreact", "typescript", "ruby" },
	user_default_options = {
		tailwind = true,
		-- virtualtext = "■",
		mode = "background", -- virtualtext | background
	},
})
