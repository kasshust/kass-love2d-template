--PreRoom--　初期化用ルーム
PreRoom = {
    new = function(property)
      local obj = instance(PreRoom,OtherRoom,property)
      --このゲームのマネージャーを登録
  
      -------初期設定--------------------------------
      --標準フォント設定
      font = love.graphics.newFont( "game/materials/fonts/PixelMplus12-Regular.ttf" , 12 )
      font:setFilter( "nearest", "nearest", 1 )
      love.graphics.setFont(font);
  
      --スプライトシートの読み込み(ゲーム別)
      sprite = {}
      sprite.test1 = load_image("game/materials/images/test/sprite_test.png")
      sprite.test2 = load_image("game/materials/images/test/spr_test.png")
      sprite.test3 = load_image("game/materials/images/test/spr_test2.png")
  
      --manager作成
      manager:apply(Manager_building.new())
      if(DEBUG) then trans(T_normal,BuildingRoom,{})end
      return obj
    end;
    u = function(self,dt)
      --なんかムービーとかロゴとか
      trans(T_normal,BuildingRoom,{})
    end;
    dg = function(self)
      g.print("なんかロゴとか",W/2,H/2)
    end;
  }