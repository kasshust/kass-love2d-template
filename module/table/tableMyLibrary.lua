function removeFromTable(o,t)
    for i,v in ipairs(t) do
        if o == v then
            table.remove(t,i)
            do break end
        end
    end
end
