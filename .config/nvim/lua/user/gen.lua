require('gen').setup({
  model = "mistral",      -- The default model to use.
  host = "localhost",     -- The host running the Ollama service.
  port = "11434",         -- The port on which the Ollama service is listening.
  display_mode = "split", -- The display mode. Can be "float" or "split".
})

vim.keymap.set({ 'n', 'v' }, '<leader>ai', ':Gen<CR>')
