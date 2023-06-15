local rhcmp={};

source = require('Rhcmp/source');
window = require('Rhcmp/window');


rhcmp.setup = function()
	source.loadGrammers();
	source.loadSnippets();
	-- TODO, window.setupCompletionWindow();
	-- TODO, autocmd.createAutoCommands();
end



return rhcmp;
