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

function M.get_ruby_version()
  local handle = io.popen("ruby --version 2>/dev/null")
  if not handle then return nil end
  local result = handle:read("*a")
  handle:close()
  if not result or result == "" then return nil end
  local major, minor = result:match("ruby (%d+)%.(%d+)")
  if major and minor then
    return tonumber(major), tonumber(minor)
  end
  return nil
end

return M
