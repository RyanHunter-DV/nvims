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

ls.add_snippets("systemverilog", {
	-- trigger is `fn`, second argument to snippet-constructor are the nodes to insert into the buffer on expansion.
	s("test", {
		-- Simple static text.
		t("//Parameters: "),
		-- function, first parameter is the function, second the Placeholders
		-- whose text it gets as input.
		f(copy, 2),
		t({ "", "function " }),
		-- Placeholder/Insert.
		i(1),
		t("("),
		-- Placeholder with initial text.
		i(2, "int foo"),
		-- Linebreak
		t({ ") {", "\t" }),
		-- Last Placeholder, exit Point of the snippet.
		i(0),
		t({ "", "}" }),
	}),
	s("driver", {
		t("// uvm_driver: "),
		f(copy,1),
		t({"","// This class generated by snippet: 'driver', if has any issue, pls report to RyanHunter"}),
		t({"","class "}),
		i(1),
		t({" #(type REQ=uvm_sequence_item,RSP=REQ) extends RhDriverBase#(REQ,RSP);"}),
		t({"","\t`uvm_component_utils_begin("}),
		f(copy,1),t({"#(REQ,RSP))"}),
		t({"","\t`uvm_component_utils_end",""}),
		t({"\tfunction new(string name=\""}),f(copy,1),t({"\",uvm_component parent=null);"}),
		t({"","\t\tsuper.new(name,parent);","\tendfunction"}),
		t({"","\textern virtual function void build_phase(uvm_phase phase);"}),
		t({"","\textern virtual function void connect_phase(uvm_phase phase);"}),
		t({"","\textern virtual function void run_phase(uvm_phase phase);"}),
		t({"","\textern virtual task mainProcess();"}),
		t({"","endclass"}),
		t({"","function void "}),f(copy,1),t("::build_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.build_phase(phase);"}),
		t({"","endfunction // ##}}}"}),
		t({"","function void "}),f(copy,1),t("::connect_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.connect_phase(phase);"}),
		t({"","endfunction // ##}}}"}),
		t({"","task "}),f(copy,1),t("::run_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.run_phase(phase);"}),
		t({"","endtask // ##}}}"}),
		t({"","task "}),f(copy,1),t("::mainProcess(); // ##{{{"),
		t({"","endtask // ##}}}"}),
		i(0),
	}),
	s("monitor", {
		t("// uvm_monitor: "),
		f(copy,1),
		t({"","// This class generated by snippet: 'monitor', if has any issue, pls report to RyanHunter"}),
		t({"","class "}),
		i(1),
		t({" #(type REQ=uvm_sequence_item,RSP=REQ) extends RhMonitorBase#(REQ,RSP);"}),
		t({"","\t`uvm_component_utils_begin("}),
		f(copy,1),t({"#(REQ,RSP))"}),
		t({"","\t`uvm_component_utils_end",""}),
		t({"\tfunction new(string name=\""}),f(copy,1),t({"\",uvm_component parent=null);"}),
		t({"","\t\tsuper.new(name,parent);","\tendfunction"}),
		t({"","\textern virtual function void build_phase(uvm_phase phase);"}),
		t({"","\textern virtual function void connect_phase(uvm_phase phase);"}),
		t({"","\textern virtual function void run_phase(uvm_phase phase);"}),
		t({"","\textern virtual task mainProcess();"}),
		t({"","endclass"}),
		t({"","function void "}),f(copy,1),t("::build_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.build_phase(phase);"}),
		t({"","endfunction // ##}}}"}),
		t({"","function void "}),f(copy,1),t("::connect_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.connect_phase(phase);"}),
		t({"","endfunction // ##}}}"}),
		t({"","task "}),f(copy,1),t("::run_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.run_phase(phase);"}),
		t({"","endtask // ##}}}"}),
		t({"","task "}),f(copy,1),t("::mainProcess(); // ##{{{"),
		t({"","endtask // ##}}}"}),
		i(0),
	}),
	s("component", {
		t("// uvm_component: "),
		f(copy,1),
		t({"","// This class generated by snippet: 'component', if has any issue, pls report to RyanHunter"}),
		t({"","class "}),
		i(1),
		t({" extends uvm_component;"}),
		t({"","\t`uvm_component_utils_begin("}),f(copy,1),t({")"}),
		t({"","\t`uvm_component_utils_end",""}),
		t({"\tfunction new(string name=\""}),f(copy,1),t({"\",uvm_component parent=null);"}),
		t({"","\t\tsuper.new(name,parent);","\tendfunction"}),
		t({"","\textern virtual function void build_phase(uvm_phase phase);"}),
		t({"","\textern virtual function void connect_phase(uvm_phase phase);"}),
		t({"","\textern virtual function void run_phase(uvm_phase phase);"}),
		t({"","endclass"}),
		t({"","function void "}),f(copy,1),t("::build_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.build_phase(phase);"}),
		t({"","endfunction // ##}}}"}),
		t({"","function void "}),f(copy,1),t("::connect_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.connect_phase(phase);"}),
		t({"","endfunction // ##}}}"}),
		t({"","task "}),f(copy,1),t("::run_phase(uvm_phase phase); // ##{{{"),
		t({"","\tsuper.run_phase(phase);"}),
		t({"","endtask // ##}}}"}),
		i(0),
	}),
	s("createcomp", {
		t({"// This code generated by snippet: 'create', if has any issue, pls report to RyanHunter",""}),
		i(1,"<InstName>"),t({" = "}),i(2,"<ClassType>"),t("::type_id::create(\""),
		f(copy,1),t("\",this);"),
		i(0),
	}),
	s("createobj", {
		t({"// This code generated by snippet: 'create', if has any issue, pls report to RyanHunter",""}),
		i(1,"<InstName>"),t({" = "}),i(2,"<ClassType>"),t("::type_id::create(\""),
		f(copy,1),t("\");"),
		i(0),
	}),
	s("task", {
		t({"// TODO, To copy the prototype part into the class declaration",""}),
		t({"\textern task "}),i(1,"<TaskName>"),t(" ("),i(2,"<Arguments>"),t(");"),
		t({"","// This code generated by snippet: 'task', if has any issue, pls report to RyanHunter",""}),
		t({"","task "}),i(3,"<ClassType>"),t("::"),f(copy,1),t("("),f(copy,2),t(");"),
		t({"","endtask"}),
		i(0),
	}),
	s("if", {
		t({"// This code generated by snippet: 'if', if has any issue, pls report to RyanHunter",""}),
		t("if ("),i(1,"<Condition>"),t({") begin","\t"}),
		i(2,"<Expression>"),t({"","end"}),
		i(0),
	}),
	s("if-else", {
		t({"// This code generated by snippet: 'if-else', if has any issue, pls report to RyanHunter",""}),
		t("if ("),i(1,"<Condition>"),t({") begin","\t"}),
		i(2,"<Expression>"),t({"","end else begin","\t"}),
		i(3,"<Expression>"),
		t({"","end"}),
		i(0),
	}),
}, {
	key = "systemverilog",
})
