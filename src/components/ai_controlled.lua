return Concord.component("ai_controlled", function(self, has_item, keep_splat_time)
    self.has_item = has_item or false
    self.keep_splat_time = keep_splat_time or 5
end)