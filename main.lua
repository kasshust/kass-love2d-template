--シーン内で毎フレーム処理させるインスタンスはここにぶっこむ
ObjectTable = {}
StaticObjectTable = {}

-- 検索用テーブル
EnemyTable = {}


--ライブラリと自作クラス
require_all("library/own")
require_all("library/base")
--ゲーム読み込み
require_all("game")

print("----------load luafile---------")

--外部ライブラリの読み込み
  maid64 = require("library/external/maid64/maid64")
  HC = require("library/external/HC")
  HC.resetHash(64)
  --shapes = require 'library/external/HC.shapes'
  polygon = require 'library/external/HC.polygon'
  sti = require("library/external/sti")
  sfxr = require("library/external/sfxrlua/sfxr")
  g_soundmanager = require("library/external/soundmanager/soundmanager")
  tween = require("library/external/tween/tween")
  gamera = require("library/external/gamera/gamera")
  json = require("library/external/json/json")


--GC実行閾値初期化
gc_threshold = 1000

function love.load()
  -----------システム設定-------------------------
  --Windowサイズの設定 コレ基準
  window_title = love.window.getTitle( )
  W,H = love.window.getMode( )
  love.window.setMode(W, H, {resizable=true, minwidth = W, minheight = H})
  
  --maid64設定
  maid64.setup(W,H)
  --wheelの初期値
  wheel_x,wheel_y = 0,0

  --gui,mouseの座標
  g_x,g_y = 0,0
  m_x,m_y = 0,0

  --デバッグ
  DEBUG = true
  
  --ジョイスティック
  p1joystick = nil

  --1,システムマネージャー ゲームを放り込む
  g_manager = Manager.new()
  addS(g_manager)
  --2,イベントマネージャー
  g_eventmanager = EventManager.new()
  addS(g_eventmanager)

  --3メインのカメラ
  --stageの大きさを設定 ->各ルームで上書きして
  g_maincam = gamera.new(0,0,W,H)
  --カメラwindowの大きさを設定
  local camWindowScale = 1
  g_maincam:setWindow(0,0,W*camWindowScale,H*camWindowScale)
  --maincam制御
  g_camStand = CamStand.new(g_maincam)
  addS(g_camStand)

  --4デバッガ
  g_debugger = Debugger.new()
  --5シーンのマネージャー
  --最初のシーンを指定
  g_scenemanager = SceneManager:new(PreRoom.new())

  --6 描画バッファ
  buffer = love.graphics.newCanvas(W, H)
  buffer2 = love.graphics.newCanvas(W, H)

end

function love.update(dt)
  ----ゲームのupdate----
    g_scenemanager:update(dt)
  ----マネージャー-------
    --デバッガー
    if DEBUG == true then g_debugger:update(dt) end
    --最小音声管理
    g_soundmanager:update(dt)
    --入力機器
    controller.updateKeys()

    -- 以下はループ内などで実行
    if collectgarbage("count") > gc_threshold then
    	collectgarbage("step",2000)
    	gc_threshold = collectgarbage("count") + 250
    	--print( "threshold set to ".have.gc_threshold)
    else
    	gc_threshold = gc_threshold - 1
    end

    -- debugコマンド
    --[[
    if DEBUG then 
      if love.keyboard.isDown( "d" ) then
        debug.debug()
      end
    end
    ]]

    if debuggee then debuggee.poll() end
end

function love.draw()
  --gui用座標の取得
  local x,y = g_maincam:getPosition()
  g_x,g_y = x-W/2,y-H/2
  m_x,m_y = g_x+maid64.mouse.getX(),g_y+maid64.mouse.getY()

  -- 描画フローを再確認すべき

  -- bufferにシーンを書き込み
  love.graphics.setCanvas(buffer)
    love.graphics.clear()
    g_scenemanager:draw()
  love.graphics.setCanvas()

  -- ポストエフェクト1
  love.graphics.setCanvas(buffer2)
  love.graphics.clear()
    
    Sh_ClampColor:send("resolution",{W,H})
    Sh_ClampColor:send("Time",0/600)
    love.graphics.setShader(Sh_ClampColor)
    love.graphics.draw(buffer,0,0)
    love.graphics.setShader()

  love.graphics.setCanvas()

  -- ピクセルパーフェクト
  --ゲームのdraw
  maid64.start()
    love.graphics.draw(buffer2,0,0)
  maid64.finish()

  

  --デバッガー
  love.window.setTitle(window_title .. " " ..tostring(love.timer.getFPS()))
  if DEBUG == true then g_debugger:draw() end
  
end

function love.joystickadded(joystick)
  p1joystick = joystick
end

function love.resize(w, h)
  maid64.resize(w,h)
end

function love.filedropped( file )
  print(file:getFilename())
  print(file:getSize( ))
  contents, size = file:read( file:getSize( ))

  print(contents)

  f = love.filesystem.newFile("test.png")
  f:open("w")
  for i = 1, 10 do
      f:write(contents)
  end
  f:close()

  sprite.test4 = load_image(f)

  success = love.filesystem.remove(f:getFilename())
  print("remove")

end


-------------------debug.debug()用------------------------

-- tableの中身を展開
function pt( table )
  for i,v in pairs(table)do
    print( i ,' = ', v )
  end
end

-- tableの中身を全て展開
function ptAll( table , tab)
  
  if tab == nil then tab = ''
  else tab = tab .. "     " end

  for i,v in pairs(table)do
    if type(v) ~= "table" then 
      print( tab .. i .. ' = ' , v )
    else 
      print( tab .. i .. ' = ', v )
      ptAll( v , tab ) 
    end
  end
end

-- ObjectTableの一覧表示
function ptOT( )
  for i,v in pairs(ObjectTable)do
    print( i ,' = ', v.name )
  end
end
