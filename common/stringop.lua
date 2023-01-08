local stringop = {}
stringop.split = function(self,s)
	local sep = ' '
	local matches = {}
	matches = vim.split(s,sep)
	for i,v in ipairs(matches) do
		if v=='' then
			table.remove(matches,i)
		end
	end
	return matches
end
return stringop
