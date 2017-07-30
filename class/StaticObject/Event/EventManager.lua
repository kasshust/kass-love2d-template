--[[
  ルームを超えて制御ができる
  インスタンスと順番を登録し、順に処理を行わせる
  event->event->event
]]

EventManager = {
  new = function()
    local obj = instance(EventManager,StaticObject)
    obj.queue = Queue.new()
    obj.event = nil
    return obj
  end;
  update = function(self,dt)
    if self.event ~= nil then
      self.event:update(dt)
      --もしイベントが死んでいたら次イベントを発火
      if self.event.kill then
         self.event = nil
         self:next()
      end
    end
  end;
  draw = function(self)
    if self.event ~= nil then self.event:draw() end
  end;
  drawGUI = function(self)
    if DEBUG then
      g.print("event : " .. self.queue:count(),g_x + 10,g_y)
      if self.event ~= nil then g.print(self.event.name,g_x + 10,g_y + 20) end
    end
    if self.event ~= nil then self.event:drawGUI() end
  end;
  add = function(self,event)
    if self.queue:isEmpty() then
      self.queue:enqueue(event)
      self:start()
    else self.queue:enqueue(event)
    end
  end;
  next = function(self)
    self.queue:dequeue()
    if not self.queue:isEmpty() then
      self:start()
    else
      --破棄して再度生成
      debugger:print("全てのeventが終了しました")
      self.queue = nil
      self.queue = Queue.new()
    end
  end;
  --eventを始める
  start = function(self)
    self.event = self.queue:top()
    --登録したイベントを発火
    self.event:init()
  end;
};

--[[
  全Eventの親クラス
  killをtrueにして次のeventに交代
]]
Event = {
  new = function()
    local obj = instance(Event)
    obj.kill = false --trueでEventから抜ける
    obj.name = "event"
    return obj
  end;
  init = function(self)end;
  update = function(self,dt)end;
  draw = function(self)end;
  drawGUI = function(self)end;
};


--[[
  CustomEvent　たぶんなんでもできる！
]]
CustomEvent = {
  new = function(f)
    local obj = instance(CustomEvent,Event)
    obj.name = "custom event"
    f(obj)
    return obj
  end;
}
