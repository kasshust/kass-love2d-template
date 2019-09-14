--PreRoom--　初期化用ルーム
PreRoom = {
    new = function(property)
      local obj = instance(PreRoom,OtherRoom,property)
      --このゲームのマネージャーを登録
  
      -------初期設定--------------------------------
      --標準フォント設定
      font = love.graphics.newFont( "game/materials/fonts/PixelMplus12-Regular.ttf" , 14 )
      font:setFilter( "nearest", "nearest", 1 )
      love.graphics.setFont(font);
  
      --スプライトシートの読み込み(ゲーム別)
      sprite = {}
      --sprite.test1 = load_image("game/materials/images/test/sprite_test.png")
      --sprite.test2 = load_image("game/materials/images/test/spr_test.png")
      --sprite.test3 = load_image("game/materials/images/test/spr_test2.png")
      --sprite.test = load_image("game/materials/images/test/sprite_test2.png")
     
      --manager作成
      g_manager:apply(M_GomGame.new())
      --if(DEBUG) then trans(T_normall,BuildingRoom,{})end
      return obj
    end;
    u = function(self,dt)
      --なんかムービーとかロゴとか
      trans(Transition,Room_GomGameOpening,{})
    end;
    dg = function(self)
      g.clear(ASE.WHITE)
      g.print("初期化",W/2,H/2)
    end;
  }