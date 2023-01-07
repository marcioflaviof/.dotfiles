local h_status_ok, harpoon = pcall(require, "harpoon")
if not h_status_ok then
	return
end

harpoon.setup({
	global_settings = {
		mark_branch = true,
	},
})
