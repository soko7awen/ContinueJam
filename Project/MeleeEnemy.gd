extends CharacterBody2D

const fallSpeed = 150
const speed = 150

var isFalling = true
var facingRight = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if position.y > get_viewport_rect().size.y*.75:
		set_collision_mask_value(2,true)
	if(isFalling):
		velocity.y = fallSpeed
		if(is_on_floor()):
			isFalling = false
	else:
		if(facingRight):
			velocity.x = speed
		else:
			velocity.x = -speed
		velocity.y += gravity * delta;
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if(collision.get_normal().x == 1 && !facingRight || collision.get_normal().x == -1 && facingRight):
				facingRight = !facingRight
	velocity.y = fallSpeed
	move_and_slide()
