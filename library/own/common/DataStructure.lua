--[[
  Stack
  queue

]]

Stack = {}

function Stack.new()
  local obj = { buff = {} }
  return setmetatable(obj, {__index = Stack})
end
function Stack:push(x)
  table.insert(self.buff, x)
end
function Stack:pop()
  return table.remove(self.buff)
end
function Stack:top()
  return self.buff[#self.buff]
end
function Stack:isEmpty()
  return #self.buff == 0
end

Queue = {}
function Queue.new()
  local obj = { buff = {} }
  return setmetatable(obj, {__index = Queue})
end
function Queue:enqueue(x)
  table.insert(self.buff, x)
end
function Queue:dequeue()
  return table.remove(self.buff, 1)
end
function Queue:top()
  if #self.buff > 0 then
    return self.buff[1]
  end
end
function Queue:isEmpty()
  return #self.buff == 0
end
function Queue:count()
  return #self.buff
end
