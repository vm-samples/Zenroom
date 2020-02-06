-- This file is part of Zenroom (https://zenroom.dyne.org)
--
-- Copyright (C) 2018-2019 Dyne.org foundation
-- designed, written and maintained by Denis Roio <jaromil@dyne.org>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

local J = require('json')


J.decode = function(data)
   if not data then error("JSON.decode error decoding nil string", 2) end
   -- assert(str ~= "","JSON.decode error decoding empty string")
   -- assert(type(str) == "string", "JSON.decode error unsopported type: "..type(str))
   local res = JSON.raw_decode( str(data) )
   if not res then error("JSON.decode error decoding type: "..t, 2) end
   return res
end

J.encode = function(tab)
   return
	  JSON.raw_encode(
		 -- process encodes zencode types
		 -- it is part of inspect.lua
		 INSPECT.process(tab)
	  )
   -- return JSON.raw_encode(tab)
end

J.auto = function(obj)
   local t = type(obj)
   if t == 'table' then
	  -- export table to JSON
	  return JSON.encode(obj)
   elseif t == 'string' then
	  -- import JSON string to table
	  return JSON.decode(obj)
   else
	  error("JSON.auto unrecognised input type: "..t, 3)
	  return nil
   end
end

return J
