--ポーズ
E_Pause = {
  new = function(bool)
    local obj = instance(E_Pause,Event)
    obj.name = "PauseEvent"
    obj.bool = bool
    return obj
  end;
  init = function(self)
    scenemanager.c_scene.pause = self.bool
    debugger:print("---E:PAUSE : ", self.bool )
    self.kill = true
  end
}

--指定秒だけイベントをストップ
E_Stop = {
   new = function(time)
     local obj = instance(E_Stop,Event)
     obj.name = "E_Stop"
     obj.time = time
     obj.frame = 0
     return obj
   end;
   step = function(self,dt)
     self.frame = self.frame + 1
     if self.frame > obj.time then self.kill = true end
   end;
 }
