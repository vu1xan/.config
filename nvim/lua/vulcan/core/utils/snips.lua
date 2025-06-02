local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("python", {
	s("cell", {
		t("#%%"),
		t({ "", "", "" }),
		i(1, "# new block", ""),
		t({ "", "" }),
		t({ "", "#%%" }),
	}),
})

return {}
