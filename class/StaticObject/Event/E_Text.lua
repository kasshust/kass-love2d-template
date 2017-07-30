--テキスト表示
TestEvent = {
  new = function()
    local obj = instance(TestEvent,Event)
    obj.name = "testEvent"
    obj.window = TextWindow.new(nil,{"テストイベントです。テキストを表示します。","改行どうしようね。めんどくさいよ。どうしようどうしよう！","次で削除"},W/2,H/2,W-30,75,10,0)
    return obj
  end;
  update = function(self,dt)
    self.window:update(dt)
    if self.window.kill == true then self.kill = true end
  end;
  drawGUI = function(self)
    self.window:drawGUI()
  end;
}
