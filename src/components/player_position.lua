return Concord.component("player_position", function(self, x, y)
    self.x = x or 0
    self.y = y or 0
end)