local debug = {}

debug.logfile = io.open('nvimsDebugFileLog','w')
debug.log = function(message)
	-- print(string.format("calling log, message: %s",message))
	debug.logfile:write(message..'\n')
end

return debug
