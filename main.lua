require_all("module")
require_all("Scene")
HC = require("library/HC")
tween = require("library/tween/tween")

function love.load()
    ---Windowサイズの設定
    W,H = 640,480
    love.window.setMode(W, H, {resizable=true, minwidth = W, minheight = H})

    scenemanager = SceneManager:new(Room1.new())
end
function love.update(dt)
    scenemanager:update(dt)
    collectgarbage("collect")
    love.keyboard.updateKeys()
end
function love.draw()
    scenemanager:draw()
    draw_status()
end
