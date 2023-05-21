extends CharacterBody2D

const fallSpeed = 150
const speed = 200

var isFalling = true
var facingRight = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(delta):
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
	move_and_slide()
