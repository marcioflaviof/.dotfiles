local M = {}

function M.filter(arr, fn)
	if type(arr) ~= "table" then
		return arr
	end
	local filtered = {}
	for k, v in pairs(arr) do
		if fn(v, k, arr) then
			table.insert(filtered, v)
		end
	end
	return filtered
end

function M.filterReactDTS(value)
	return string.match(value.filename, "react/index.d.ts") == nil
end

function M.on_list(options)
	local items = options.items
	if #items > 1 then
		items = M.filter(items, M.filterReactDTS)
	end
	vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
	vim.api.nvim_command("cfirst")
end

---Major Ruby version for the current project.
---
---Reads `.ruby-version` or the `ruby` line in the Gemfile, walking up from the
---buffer. The old implementation shelled out to `ruby --version` with io.popen
---on every launch: a blocking subprocess that reported the *global* toolchain
---rather than whatever the project pins.
---@return integer|nil major
function M.get_ruby_version()
	local root = vim.fs.root(0, { ".ruby-version", "Gemfile", ".git" })
	if not root then
		return nil
	end

	local version_file = vim.fs.joinpath(root, ".ruby-version")
	if vim.uv.fs_stat(version_file) then
		local line = (vim.fn.readfile(version_file, "", 1) or {})[1]
		local major = line and line:match("(%d+)%.%d+")
		if major then
			return tonumber(major)
		end
	end

	local gemfile = vim.fs.joinpath(root, "Gemfile")
	if vim.uv.fs_stat(gemfile) then
		for _, line in ipairs(vim.fn.readfile(gemfile) or {}) do
			local major = line:match("^%s*ruby%s+[\"'](%d+)%.%d+")
			if major then
				return tonumber(major)
			end
		end
	end

	return nil
end

return M
