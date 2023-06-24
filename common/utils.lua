local u={};

u.tableMaxItemLength=function(t)
	local ml=0;
	for k,v in pairs(t) do
		if ml < string.len(v) then
			ml = string.len(v);
		end
	end
	return ml;
end


return u;
