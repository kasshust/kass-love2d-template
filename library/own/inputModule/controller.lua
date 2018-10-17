--[[

  a b x y r1 l1 r2 l2 start select right left up down
  ↓コンバート
  キーボード　ゲームパッド　マウス

]]



controller = {}
controller.Pressed = {}
controller.Released = {}
controller.Down = {}


function controller.wasPressed(button)
    if (controller.Pressed[button]) then
        return true
    else
        return false
    end
end
function controller.wasReleased(button)
    if (controller.Released[button]) then
        return true
    else
        return false
    end
end

function controller.updateKeys()
  gamepad.updateKeys()
  love.keyboard.updateKeys()
  love.mouse.updateKeys()
  controller.Pressed = {}
  controller.Released = {}
end

function controller.isDown(button)
  return controller.Down[button]
end
