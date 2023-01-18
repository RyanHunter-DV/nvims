local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local r = ls.restore_node
local uvm = {}

local function copy(args)
	return args[1]
end
local function testf()
	rawtest = vim.fn.system({"echo help"})
	test = string.gsub(rawtest,"\n","")
	return {test}
end

ls.add_snippets("ruby", {
	s("def", {
		t({"def "}),i(1,"<DefName(args)>"),t({" ##{{{"}),
		t({"","\t"}),i(0),
		t({"","end ##}}}"}),
	}),
}, {
	key = "ruby",
})
