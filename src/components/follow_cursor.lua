return Concord.component("follow_cursor", function(self, offset_x, offset_y)
    self.offset_x = offset_x or 0
    self.offset_y = offset_y or offset_x
end)