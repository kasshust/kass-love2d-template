--ゲーム固有のエンティティマネージャー
--ゲームによって検索用Managerの取り扱いを変える

-- 検索用テーブル

EntityManager = {
    new = function()
      local obj = instance(EntityManager,GameManager)
      
      -- エネミーテーブル
      obj.EnemyTable = {}

      -- ダミーテーブル
      
      return obj
    end;

    update = function(self,dt)
    end;

    init = function(self)
      self.EnemyTable = nil
      self.EnemyTable = {}

    end;

    -- 検索用テーブルにオブジェクトを追加
    add = function(self,tag,obj)

      if tag == "enemy" then
        self.EnemyTable[obj.id] = obj
      end

    end;

    delete = function(self,tag,id)
      if tag == "enemy" then
        self.EnemyTable[id] = nil
      end
    end;

    -- 最もx,yに近いオブジェクトを検索
    searchNearObj = function(self,tag,x,y)
      
      local pos = Vector.new(x,y)

      if tag == "enemy" then
          local near = nil
          for k, v in pairs(self.EnemyTable) do
            if near == nil then near = v 
          else
            if (v.pos-pos):len() < (near.pos-pos):len() then
              near = v
            end
          end
          
          end

          return near
      end

      print("Error:tag is not matched")
      return nil
    end

};
