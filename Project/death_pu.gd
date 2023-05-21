extends CharacterBody2D

const fallSpeed = 150

var isFalling = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if position.y > get_viewport_rect().size.y*.75:
		set_collision_mask_value(2,true)
	if(isFalling):
		velocity.y = fallSpeed
		if(is_on_floor()):
			isFalling = false
		velocity.y += gravity * delta;
	velocity.y = fallSpeed
	move_and_slide()
