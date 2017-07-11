require_all("module")
require_all("Scene")
HC = require("library/HC")
collide = HC.new(100)
tween = require("library/tween/tween")
gamera = require("library/gamera/gamera")

function love.load()
    ---起動前の初期設定
    --Windowサイズの設定 コレ基準
    W,H = love.window.getMode( )
    --wheelの初期値
    wheel_x,wheel_y = 0,0
    --デバッグ
    DEBUG = true
    --window初期設定
    love.window.setMode(W, H, {resizable=true, minwidth = W, minheight = H})

    ---Manager Object

    --メインのカメラ
    --stageの大きさを設定
    maincam = gamera.new(0,0,640,480)
    --カメラwindowの大きさを設定
    camWindowScale = 1
    maincam:setWindow(0,0,W*camWindowScale,H*camWindowScale)

    --デバッガ
    debugger = Debugger.new()

    --シーンのマネージャー
    scenemanager = SceneManager:new(Title.new())

    --マネージャー
    manager = Manager.new()

    --フォント設定
    font = love.graphics.newFont( "fonts/SourceHanSerif-Medium.ttc" , 12 )
    love.graphics.setFont(font);

    table.insert(StaticObjectTable,manager)
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

function love.resize(w, h)
  local scale = math.min(w / W ,h / H)
  camWindowScale = scale
  maincam:setWindow((w / 2) - (W*camWindowScale/2),(h / 2) - (H*camWindowScale/2),W*camWindowScale,H*camWindowScale)
  maincam:setScale(camWindowScale)
end
