--(例)遷移イベント
E_Transition = {
  new = function(class,room,property)
    local obj = instance(E_Transition,Event)
    obj.name = "E_Transition"
    --トランジションを生成しておく
    obj.transition = class.new(room,property)
    return obj
  end;
  init = function(self) g_debugger:print("---E:遷移イベントが発火しました") end;
  update = function(self,dt)
    self.transition:update(dt)
    if self.transition.kill == true then self.kill = true g_debugger:print("---E:遷移イベントが終了しました") end
  end;
  drawGUI = function(self)
    self.transition:drawGUI()
  end;
}
