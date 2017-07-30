--(例)遷移イベント
E_Transition = {
  new = function(room)
    local obj = instance(E_Transition,Event)
    obj.name = "testEvent2"
    --トランジションを生成しておく
    obj.transition = T_normal.new(room)
    return obj
  end;
  init = function(self) debugger:print("---E:遷移イベントが発火しました") end;
  update = function(self,dt)
    self.transition:update(dt)
    if self.transition.kill == true then self.kill = true debugger:print("破棄") end
  end;
  drawGUI = function(self)
    self.transition:drawGUI()
  end;
}
