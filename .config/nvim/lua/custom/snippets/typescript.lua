-- require("luasnip.session.snippet_collection").clear_snippets "typescriptreact"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescriptreact", {
  s("arr", fmt("const {} = ({}) => {{\n\t{}\n}}", { i(1), i(2), i(0) })),
})
