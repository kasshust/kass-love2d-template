gamepad = {}

--[[
a
Bottom face button (A).
b
Right face button (B).
x
Left face button (X).
y
Top face button (Y).
back
Back button.
guide
Guide button.
start
Start button.
leftstick
Left stick click button.
rightstick
Right stick click button.
leftshoulder
Left bumper.
rightshoulder
Right bumper.
dpup
D-pad up.
dpdown
D-pad down.
dpleft
D-pad left.
dpright
D-pad right.
]]

gamepad.Pressed = { }
gamepad.Released ={ }

-----共通コンバータ------
gamepad.convert = {}
gamepad.convert["a"] = "a"
gamepad.convert["b"] = "b"
gamepad.convert["x"] = "x"
gamepad.convert["y"] = "y"
gamepad.convert["rightshoulder"] = "r1"
gamepad.convert["leftshoulder"] = "l1"
gamepad.convert["triggerright"] = "r2"
gamepad.convert["triggerleft"] = "l2"
gamepad.convert["start"] = "start"
gamepad.convert["guide"] = "select"
gamepad.convert["dpright"] = "right"
gamepad.convert["dpleft"] = "left"
gamepad.convert["dpup"] = "up"
gamepad.convert["dpdown"] = "down"


--[[
function love.gamepad.init()
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end
]]

function gamepad.wasPressed(button)
    if (gamepad.Pressed[button]) then
        return true,gamepad.Pressed[button]
    else
        return false
    end
end

function gamepad.wasReleased(button)
    if (gamepad.Released[button]) then
        return true,gamepad.Released[button]
    else
        return false
    end
end

function love.gamepadpressed( joystick, button )
    gamepad.Pressed[button] = true

    local b = gamepad.convert[button]
    if b ~= nil then
      controller.Pressed[b] = true
      controller.Down[b] = true
    end
end

function love.gamepadreleased( joystick, button )
    gamepad.Released[button] = true

    local b = gamepad.convert[button]
    if b ~= nil then
      controller.Released[b] = true
      controller.Down[b] = false
    end
end

function love.gamepadaxis( joystick, axis, value )
    gamepad.Pressed[axis] = value
    gamepad.Released[axis] = value
    
    local b = gamepad.convert[button]
    if b ~= nil then
      controller.Pressed[b] = value
      controller.Released[b] = value
    end
end

function gamepad.updateKeys()
    gamepad.Pressed = { }
    gamepad.Released = { }
end
