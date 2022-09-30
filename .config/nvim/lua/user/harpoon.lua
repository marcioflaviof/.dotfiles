local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local h_status_ok, _ = pcall(require, "harpoon")
if not h_status_ok then
  return
end
telescope.load_extension "harpoon"
