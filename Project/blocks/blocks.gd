extends RigidBody2D

func _ready():
	pass

func _process(delta):
	if position.y > get_viewport_rect().size.y*.75:
		set_collision_mask_value(2,true)
