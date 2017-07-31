gamepad = {}

--[[
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

--[[
function love.gamepad.init()
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end
]]

function gamepad.wasPressed(button)
    if (gamepad.Pressed[button]) then
        return true
    else
        return false
    end
end

function gamepad.wasReleased(button)
    if (gamepad.Released[button]) then
        return true
    else
        return false
    end
end

function love.gamepadpressed( joystick, button )
    gamepad.Pressed[button] = true
end

function love.gamepadreleased( joystick, button )
    gamepad.Released[button] = true
end

function gamepad.updateKeys()
    gamepad.Pressed = { }
    gamepad.Released = { }
end