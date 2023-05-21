extends CharacterBody2D

const fallSpeed = 150

var isFalling = true

func _physics_process(delta):
	velocity.y = fallSpeed
	move_and_slide()
