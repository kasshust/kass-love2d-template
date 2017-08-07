--シーン内で毎フレーム処理させるインスタンスはここにぶっこむ
ObjectTable = {}
StaticObjectTable = {}

--ライブラリと自作クラス
require_all("scene")
require_all("ObjectClass")
require_all("library/own")
require_all("library/base")

--ゲーム読み込み
require_all("game")

--外部ライブラリの読み込み
  maid64 = require("library/external/maid64/maid64")
  HC = require("library/external/HC")
  HC.resetHash(64)
  sti = require("library/external/sti")
  sfxr = require("library/external/sfxrlua/sfxr")
  soundmanager = require("library/external/soundmanager/soundmanager")
  tween = require("library/external/tween/tween")
  gamera = require("library/external/gamera/gamera")
  json = require("library/external/json/json")

function love.load()
  -----------起動前の初期設定-------------------------
      --Windowサイズの設定 コレ基準
      window_title = love.window.getTitle( )
      W,H = love.window.getMode( )
      love.window.setMode(W, H, {resizable=true, minwidth = W, minheight = H})
      --maid64設定
      maid64.setup(W,H)
      --wheelの初期値
      wheel_x,wheel_y = 0,0
      --デバッグ
      DEBUG = false

  --------kass Engine Manager-----------------
  --1,汎用的マネージャー
    manager = Manager.new()
    addS(manager)
  --2,イベントマネージャー
    eventmanager = EventManager.new()
    addS(eventmanager)

  --3メインのカメラ
    --stageの大きさを設定 ->各ルームで上書きして
      maincam = gamera.new(0,0,640,480)
      --カメラwindowの大きさを設定
      camWindowScale = 1
      maincam:setWindow(0,0,W*camWindowScale,H*camWindowScale)
    --maincam制御
        camStand = CamStand.new(maincam)
        addS(camStand)

  --4デバッガ
      debugger = Debugger.new()
  --5シーンのマネージャー
      --最初のシーンを指定
      scenemanager = SceneManager:new(PreRoom.new())
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
    controller.updateKeys()
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
  love.window.setTitle(window_title .. " " ..tostring(love.timer.getFPS()))
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
