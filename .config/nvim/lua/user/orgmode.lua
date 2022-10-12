local status_ok, orgmode = pcall(require, "orgmode")
if not status_ok then
  return
end

-- Load custom tree-sitter grammar for org filetype
orgmode.setup_ts_grammar()


orgmode.setup({
  org_agenda_files = { '~/Documents/orgmode/*' },
  org_default_notes_file = '~/Documents/orgmode/daily.org',
  org_todo_keywords = { "TODO", "HELP", "|", "DONE" }
})

local bullets_status_ok, orgbullets = pcall(require, "org-bullets")
if not bullets_status_ok then
  return
end

orgbullets.setup()
