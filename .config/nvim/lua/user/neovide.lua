if vim.g.neovide == true then
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_transparency = 0.9
  -- vim.g.neovide_no_idle = false
  -- vim.g.neovide_fullscreen = false
  -- vim.g.neovide_cursor_animation_length = 0.20
  -- vim.g.neovide_cursor_trail_length = 0.5
  -- vim.g.neovide_cursor_antialiasing = true
  -- vim.g.neovide_cursor_vfx_mode = "ripple"
  -- vim.g.neovide_cursor_vfx_opacity = 200.0
  -- vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  -- vim.g.neovide_cursor_vfx_particle_density = 7.0
  -- vim.g.neovide_cursor_vfx_particle_speed = 10.0
  -- vim.g.neovide_cursor_vfx_particle_phase = 1.5
  -- vim.g.neovide_cursor_vfx_particle_curl = 1.0

  local map = vim.keymap.set

  local function neovideScale(amount)
    local temp = vim.g.neovide_scale_factor + amount

    if temp < 0.5 then
      return
    end

    vim.g.neovide_scale_factor = temp
  end

  map("n", "<C-=>", function()
    neovideScale(0.1)
  end)

  map("n", "<C-->", function()
    neovideScale(-0.1)
  end)
  map('n', '<F11>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end
