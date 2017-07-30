--カメライベント
E_CamMoveTo = {
  new = function(x,y,time,type)
    local obj = instance(E_CamMoveTo,Event)
    obj.name = "E_CamMoveTo"
    obj.x = x or 0
    obj.y = y or 0
    obj.time = time or 1
    obj.type = type
    return obj
  end;
  init = function(self)
    debugger:print("---E:CamMoveTo:発火" .. self.x .. " : " .. self.y)
    camStand:moveTo(self.x,self.y,self.time,self.type)
  end;
  update = function(self,dt)
    --割り込みが入った
    if camStand:getStatus() ~= camStand.status.MOVETO then
      debugger:print("---E:CamMoveTo:割り込みを検知しました。強制終了します")
      self.kill = true
    end
    --終了した
    if camStand.moveTo_finish == true then self.kill = true end
  end;
};

--camStandのfocusに移動し、設定
E_CamMoveFocus = {
  new = function(time,type)
    local obj = instance(E_CamMoveFocus,Event)
    obj.name = "E_CamMoveFocus"
    obj.time = time or 1
    obj.type = type or nil
    return obj
  end;
  init = function(self)
    debugger:print("---E:CamMoveFocus:発火")
    if camStand.focus == nil then
      debugger:print("---E:CamMoveFocus:focusが設定されていません。削除します。")
      self.kill = true
    else
      camStand:moveTo(camStand.focus.pos.x,camStand.focus.pos.y,self.time,self.type)
    end
  end;
  update = function(self,dt)
    if camStand.moveTo_finish == true then
      self.kill = true
      camStand:moveFocus()
    end
  end;
};

--camStandをSeqにし、削除
E_CamMoveFocusSeq = {
  new = function(speed)
    local obj = instance(E_CamMoveFocusSeq,Event)
    obj.name = "E_CamMoveFocusSeq"
    obj.speed = speed
    return obj
  end;
  init = function(self)
    debugger:print("---E:CamMoveFocusSeq:発火")
    if camStand.focus == nil then
      debugger:print("---E:CamMoveFocusSeq:focusが設定されていません。削除します。")
      self.kill = true
    else
      camStand:moveFocusSeq(self.speed)
      self.kill = true
    end
  end;
  update = function(self,dt)
    self.kill = true
  end;
};
