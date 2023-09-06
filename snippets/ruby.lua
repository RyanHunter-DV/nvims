local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local r = ls.restore_node
-- local uvm = {}

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
		t({"## "}),i(1,"<DefName(args)>"),t({", "}),i(2,"description"),
		t({"","def "}),f(copy,1),t({" ##{{{"}),
		t({"","\t"}),i(0),
		t({"","\tputs \"method("}),f(copy,1),t({") not ready yet.\""}),
		t({"","end ##}}}"}),
	}),
	s("class", {
		t({"","\"\"\""}),
		t({"","# Object description:"}),
		t({"",""}),i(1,"<ClassName>"),t({', '}),i(2,"description"),
		t({"","\"\"\"",""}),
		t({"class "}),f(copy,1),t({" ##{{{"}),
		t({"","\t"}),i(0),
		t({"","public","\t# add public code here"}),
		t({"","private","\t# add private code here"}),
		t({"","end ##}}}"}),
	}),
	s("module", {
		t({"","\"\"\""}),
		t({"","# Object description:"}),
		t({"",""}),i(1,"<ClassName>"),t({', '}),i(2,"description"),
		t({"","\"\"\"",""}),
		t({"module "}),f(copy,1),t({" ##{{{"}),
		t({"","\t"}),i(0),
		t({"","end ##}}}"}),
	}),
}, {
	key = "ruby",
})
