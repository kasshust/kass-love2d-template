
--timeを設定し、指定フレーム後にtrueを返し、待機させる
Alarm = {
  new = function(time)
    local obj = instance(Alarm)
    obj.frame = time
    return obj
  end;
  update = function(self)
   if self.frame > 0 then self.frame = self.frame - 1 end

   if self.frame == 0 then
     self.frame = -1
     return true
   end
  end;

  set = function(self,time)
   self.frame = time
  end;
};
