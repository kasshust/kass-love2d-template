require_all("module")
require_all("Scene")
HC = require("library/HC")
tween = require("library/tween/tween")
gamera = require("library/gamera/gamera")

function love.load()
    ---Windowサイズの設定
    W,H = 640,480
    wheel_x,wheel_y = 0,0
    DEBUG = true
    love.window.setMode(W, H, {resizable=true, minwidth = W, minheight = H})

    --[[
      if not love.filesystem.exists("save.lua") then
          savedata = {}
          for i = 1 , 20 do
              table.insert(savedata,false)
          end
          love.filesystem.write("save.lua",Tserial.pack(savedata))
      else
          savedata = Tserial.unpack(love.filesystem.read("save.lua"))
      end
    ]]

    debugger = Debugger.new()
    scenemanager = SceneManager:new(Room1.new())
    table.insert(StaticObjectTable,Manager.new())
end

function love.update(dt)
    scenemanager:update(dt)
    if DEBUG == true then debugger:update(dt) end
    love.keyboard.updateKeys()
    love.mouse.updateKeys()

    --collectgarbage("collect")
end
function love.draw()
    scenemanager:draw()
    if DEBUG == true then debugger:draw() end
end

function love.wheelmoved( dx, dy )
    wheel_x = wheel_x + dx*0.01
    wheel_y = wheel_y + dy*0.01
  end
