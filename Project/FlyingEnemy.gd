extends CharacterBody2D

const fallSpeed = 150
const speed = 150
const jumpVelocity = -300

var isFalling = true
var facingRight = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpTimer = 0
var viewport

func _ready():
	viewport = get_viewport_rect()

func _physics_process(delta):
	if position.y > get_viewport_rect().size.y*.75:
		set_collision_mask_value(2,true)
	if position.y > get_viewport_rect().size.y*.75:
		$CollisionShape2D.disabled = false
	if(isFalling):
		velocity.y = fallSpeed
		if(position.y >= viewport.size.y / 1.2):
			isFalling = false
	else:
		if(facingRight):
			velocity.x = speed
		else:
			velocity.x = -speed
		velocity.y += gravity * delta;
		if(jumpTimer <= 0):
			jumpTimer = 5
			velocity.y = jumpVelocity
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if(collision.get_normal().x == 1 && !facingRight || collision.get_normal().x == -1 && facingRight):
				facingRight = !facingRight
		if(position.y >= viewport.size.y / 1.2):
			jumpTimer -= 1
	move_and_slide()
