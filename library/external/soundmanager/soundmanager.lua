local soundmanager = {}
soundmanager.queue = {}
soundmanager.playlist = {}
soundmanager.currentsong = -1

local function shuffle(a, b)
   return math.random(1, 2) == 1
end

-- 魔法をかけます。
function soundmanager:play(sndData)
   -- 音声データからソースを作成します。
   local src = love.audio.newSource(sndData, "static")
   -- キューへ配置します。
   table.insert(self.queue, src)
   -- そして再生します。
   love.audio.play(src)
   
end

-- 音楽に魔法をかけます。
function soundmanager:playMusic(first, ...)
   -- 現在再生中の音楽を全て停止します。
   for i, v in ipairs(self.playlist) do
      love.audio.stop(v)
   end
   -- テーブルまたは vararg が渡された場合に、
   -- 再生リストを組み立てるかどうか決定します。
   if type(first) == "table" then
      self.playlist = first
   else
      self.playlist = {first, ...}
   end
   self.currentsong = 1
   -- 再生
   love.audio.play(self.playlist[1])
end

-- なにかをかき混ぜます'
function soundmanager:shuffle(first, ...)
   local playlist
   if type(first) == "table" then
      playlist = first
   else
      playlist = {first, ...}
   end
   table.sort(playlist, shuffle)
   return unpack(playlist)
end

function soundmanager:stopMusic()
    -- 現在再生中の音楽を全て停止します。
    for i, v in ipairs(self.playlist) do
        love.audio.stop(v)
        print("audio stop!")
    end
    self.playlist = {}
    
    -- キューにある音声の再生が完了した、および削除されたか確認します。
   local removelist = {}
   for i, v in ipairs(self.queue) do
      if not v:isPlaying( ) then
         table.insert(removelist, i)
      end
   end
   -- ループにあるものは削除できないため、別のループを使用します。
   for i, v in ipairs(removelist) do
      table.remove(self.queue, v-i+1)
      v:release( )
   end
 end

-- 更新
function soundmanager:update(dt)
   -- キューにある音声の再生が完了した、および削除されたか確認します。
   local removelist = {}
   for i, v in ipairs(self.queue) do
      if not v:isPlaying( ) then
         table.insert(removelist, i)
      end
   end
   -- ループにあるものは削除できないため、別のループを使用します。
   for i, v in ipairs(removelist) do
      table.remove(self.queue, v-i+1)
   end
   -- 必要であればプレイリストを進めます。
   if self.currentsong ~= -1 and #self.playlist ~= 0  then
    if not (self.playlist[self.currentsong]:isPlaying()) then
      self.currentsong = self.currentsong + 1
      if self.currentsong > #self.playlist then
         self.currentsong = 1
      end
      love.audio.play(self.playlist[self.currentsong])
    end
   end
end

return soundmanager
