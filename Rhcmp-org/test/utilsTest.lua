package.path=package.path..';../?.lua';
local ut = require('utils');
local row,col = ut.getCurrentCursorPosition();
print(string.format("%s, %s",row,col));
