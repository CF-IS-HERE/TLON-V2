return function(entity)
  require 'src/states/InGame'

    entity:give("sprite", {
      image = generateSprite(),
      total_frames = 1,
      offset = Vector(5, 0)
      })
    entity:give("layer", canvasPush())
    entity:give("position", setPosition())
    entity:give("ai_controlled")
    entity:give("speed", 50)
    entity:give("hurtbox", {
        offset_x = 5,
        offset_y = 3,
        width = 6,
        height = 5,
        layer = "player",
        on_enter = function() print("enter") end,
        rendered = show_hitbox
    })
  end
