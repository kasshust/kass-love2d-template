function math.clamp(x, min, max)
    return x < min and min or (x > max and max or x)
end
function point_direction(a,b)
    local dx = b[1] - a[1]
    local dy = b[2] - a[2]

    return math.atan2(dy,dx) + math.pi
end