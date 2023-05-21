extends CharacterBody2D

const fallSpeed = 125
const speed = 125
const jumpVelocity = -400

var isFalling = true
var facingRight = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpTimer = RandomNumberGenerator.new().randf_range(100, 200)

func _ready():
	pass

func _physics_process(delta):
	if position.y > get_viewport_rect().size.y*.75:
		set_collision_mask_value(2,true)
	if position.y > get_viewport_rect().size.y*.75:
		$CollisionShape2D.disabled = false
	if(isFalling):
		velocity.y = fallSpeed
		if(is_on_floor()):
			isFalling = false
	else:
		if(facingRight):
			velocity.x = speed
		else:
			velocity.x = -speed
		velocity.y += gravity * delta
		if(jumpTimer <= 0):
			jumpTimer = RandomNumberGenerator.new().randf_range(100, 200)
			velocity.y = jumpVelocity
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if(collision.get_normal().x == 1 && !facingRight || collision.get_normal().x == -1 && facingRight):
				facingRight = !facingRight
		jumpTimer -= 1
	move_and_slide()
