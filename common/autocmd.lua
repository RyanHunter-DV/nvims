-- local debug = require('common.debug')

local autocmd = {}

autocmd.new = function(groupname)
	local self=setmetatable({},{__index = autocmd});
	self.group = vim.api.nvim_create_augroup(groupname, { clear = true })
	self.events = {};
	return self;
end


---Subscribe autocmd
---@param events string|string[]
---@param callback function
---@return function
autocmd.subscribe = function(self,events, callback)
  events = type(events) == 'string' and { events } or events

  for _, event in ipairs(events) do
    if not self.events[event] then
      self.events[event] = {}
      vim.api.nvim_create_autocmd(event, {
        desc = ('nvim-cmp: autocmd: %s'):format(event),
        group = self.group,
        callback = function()
          self:emit(event)
        end,
      })
    end
    table.insert(self.events[event], callback)
  end

  return function()
    for _, event in ipairs(events) do
      for i, callback_ in ipairs(self.events[event]) do
        if callback_ == callback then
          table.remove(self.events[event], i)
          break
        end
      end
    end
  end
end

---Emit autocmd
---@param event string
autocmd.emit = function(self,event)
	self.events[event] = self.events[event] or {}
	for _, callback in ipairs(self.events[event]) do
		callback()
	end
end


return autocmd
