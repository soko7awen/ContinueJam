extends CharacterBody2D

const fireVelocity = -300

var viewport

func _ready():
	viewport = get_viewport_rect()

func _physics_process(_delta):
	velocity.y = fireVelocity
	if(position.y <= -get_viewport_rect().size.y):
		queue_free()
	move_and_slide()
