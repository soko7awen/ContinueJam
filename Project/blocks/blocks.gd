extends StaticBody2D

func _ready():
	pass

func _process(delta):
	if position.y < get_viewport_rect().size.y:
		set_collision_mask_value(2,true)
		set_collision_mask_value(1,true)
		position.y += 200 * delta
