function removeFromTable(o,t)
    for i,v in ipairs(t) do
        if o == v then
            table.remove(t,i)
            do break end
        end
    end
end

function table.tostring(t)

  local ty = type(t)
  if ty == "string" or ty == "number" then return t end

  local string = "{"

  --ハッシュ
  local n = 1
  for k,v in pairs(t) do
    if type(v) == "table" then
      string = string .. table.tostring(v)
    elseif type(v) == "string" or type(v) == "number" then
      string = string .. k .. " = " .. v .. ","
    else
      string = string .. k .. " = " .. type(v) .. ","
    end
  end

  --配列
  for i,v in ipairs(t) do
    if type(v) == "table" then
      string = string .. table.tostring(v)
    elseif type(v) == "string" or type(v) == "number" then
      string = i ~= 1 and string .. "," .. v or string .. v
    else
      string = string .. type(v)
    end
  end
  string = string .. "}"
  return string
end
