--シーン内で毎フレーム処理させるインスタンスはここにぶっこむ
ObjectTable = {}
StaticObjectTable = {}

--ライブラリと自作クラス
require_all("scene")
require_all("ObjectClass")
require_all("library/own")

--外部ライブラリの読み込み
  maid64 = require("library/external/maid64/maid64")
  HC = require("library/external/HC")
  HC.resetHash(64)
  sti = require("library/external/sti")
  sfxr = require("library/external/sfxrlua/sfxr")
  soundmanager = require("library/external/soundmanager/soundmanager")
  tween = require("library/external/tween/tween")
  gamera = require("library/external/gamera/gamera")

function love.load()
  -----------起動前の初期設定-------------------------
      --Windowサイズの設定 コレ基準
      W,H = love.window.getMode( )
      love.window.setMode(W, H, {resizable=true, minwidth = W, minheight = H})
      --maid64設定
      maid64.setup(W,H)
      --wheelの初期値
      wheel_x,wheel_y = 0,0
      --デバッグ
      DEBUG = true

  --------Manager Object------------------

    --!メインのカメラ
      --stageの大きさを設定 ->各ルームで上書きして
        maincam = gamera.new(0,0,640,480)
        --カメラwindowの大きさを設定
        camWindowScale = 1
        maincam:setWindow(0,0,W*camWindowScale,H*camWindowScale)
      --maincam制御
        camStand = CamStand.new(maincam)
        addS(camStand)

    --!デバッガ
      debugger = Debugger.new()
    --!シーンのマネージャー
      scenemanager = SceneManager:new(Title.new())
    --!汎用的マネージャー
      manager = Manager.new()
      addS(manager)
    --イベントマネージャー
      eventmanager = EventManager.new()
      addS(eventmanager)

  -------その他設定--------------------------------
    --標準フォント設定
    font = love.graphics.newFont( "materials/fonts/PixelMplus12-Regular.ttf" , 12 )
    font:setFilter( "nearest", "nearest", 1 )
    love.graphics.setFont(font);

    --スプライトシートの読み込み(ゲーム別)
    img_test = load_image("materials/images/test/sprite_test.png")
end
function love.update(dt)
  ----ゲームのupdate----
    scenemanager:update(dt)
  ----マネージャー-------

    --デバッガー
    if DEBUG == true then debugger:update(dt) end
    --最小音声管理
    soundmanager:update(dt)
    --入力機器
    love.keyboard.updateKeys()
    love.mouse.updateKeys()
    gamepad.updateKeys()
end
function love.draw()
  --gui用座標の取得
  local x,y = maincam:getPosition()
  g_x,g_y = x-W/2,y-H/2

  --ゲームのdraw
  maid64.start()
    scenemanager:draw()
  maid64.finish()

  --デバッガー
  if DEBUG == true then debugger:draw() end
end

function love.resize(w, h)
  maid64.resize(w,h)
end

------------------------------------------------------------------
--[[maid64により不要
local scale = math.min(w / W ,h / H)
camWindowScale = scale
maincam:setWindow((w / 2) - (W*camWindowScale/2),(h / 2) - (H*camWindowScale/2),W*camWindowScale,H*camWindowScale)
maincam:setScale(camWindowScale)
]]

--[[
function love.wheelmoved( dx, dy )
    wheel_x = wheel_x + dx*0.01
    wheel_y = wheel_y + dy*0.01
    --maincam:setScale(1+wheel_y)
end
]]
