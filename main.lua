--シーン内で毎フレーム処理させるインスタンスはここにぶっこむ
ObjectTable = {}
SearchTable = {}
StaticObjectTable = {}

--ライブラリと自作クラス
require_all("module")
require_all("scene")
require_all("class")

--外部ライブラリの読み込み
m64 = require("library/maid64/maid64")
HC = require("library/HC")
sti = require("library/sti")
sfxr = require("library/sfxrlua/sfxr")
soundmanager = require("library/soundmanager/soundmanager")
--collide = HC.new(100)
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
      --stageの大きさを設定 ->各ルームで上書きして
      maincam = gamera.new(0,0,640,480)
      --カメラwindowの大きさを設定
      camWindowScale = 1
      maincam:setWindow(0,0,W*camWindowScale,H*camWindowScale)
      --ゲーム内でcamを制御
      camStand = CamStand.new(maincam)
      addS(camStand)

    --デバッガ
    debugger = Debugger.new()
    --シーンのマネージャー
    scenemanager = SceneManager:new(Title.new())
    --マネージャー
    manager = Manager.new()
    table.insert(StaticObjectTable,manager)

    --フォント設定
    font = love.graphics.newFont( "materials/fonts/SourceHanSerif-Medium.ttc" , 12 )
    font:setFilter( "nearest", "nearest", 1 )
    love.graphics.setFont(font);

    --スプライトシートの読み込み
    img_test = load_image("materials/images/test/sprite_test.png")
end
function love.update(dt)
    scenemanager:update(dt)

    --インフラ系
    soundmanager:update(dt)
    if DEBUG == true then debugger:update(dt) end
    love.keyboard.updateKeys()
    love.mouse.updateKeys()
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
