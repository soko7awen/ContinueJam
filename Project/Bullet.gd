extends CharacterBody2D

const fireVelocity = -300

var viewport

func _ready():
	viewport = get_viewport_rect()

func _physics_process(delta):
	velocity.y = fireVelocity
	if(position.y <= -100):
		queue_free()
	move_and_slide()