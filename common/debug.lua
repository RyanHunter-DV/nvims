local debug = {}

debug.logfile = io.open('nvimsDebugFileLog','w')

debug.log = function(message)
	self.logfile.write(message)
end
