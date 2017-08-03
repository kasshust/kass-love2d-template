love.keyboard.keysPressed = { }
love.keyboard.keysReleased = { }

--共通コンバータ 使わないならコメントアウト
love.keyboard.convert = {}
love.keyboard.convert["k"] = "a"
love.keyboard.convert["return"] = "a"
love.keyboard.convert["l"] = "b"
love.keyboard.convert["i"] = "x"
love.keyboard.convert["o"] = "y"
love.keyboard.convert["e"] = "r1"
love.keyboard.convert["q"] = "l1"
love.keyboard.convert["u"] = "r2"
love.keyboard.convert["p"] = "l2"
love.keyboard.convert["n"] = "start"
love.keyboard.convert["m"] = "select"
love.keyboard.convert["d"] = "right"
love.keyboard.convert["a"] = "left"
love.keyboard.convert["w"] = "up"
love.keyboard.convert["s"] = "down"


-- returns if specified key was pressed since the last update
function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end
-- returns if specified key was released since last update
function love.keyboard.wasReleased(key)
    if (love.keyboard.keysReleased[key]) then
        return true
    else
        return false
    end
end

function love.keypressed(key, unicode)
    love.keyboard.keysPressed[key] = true

    local b = love.keyboard.convert[key]
    if b ~= nil then
      controller.Pressed[b] = true
      controller.Down[b] = true
    end
end
-- concatenate this to existing love.keyreleased callback, if any
function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true

    local b = love.keyboard.convert[key]
    if b ~= nil then
      controller.Released[b] = true
      controller.Down[b] = false
    end
end
-- call in end of each love.update to reset lists of pressed\released keys
function love.keyboard.updateKeys()
    love.keyboard.keysPressed = { }
    love.keyboard.keysReleased = { }
end
