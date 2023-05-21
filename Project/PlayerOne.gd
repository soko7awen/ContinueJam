extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(_delta):
	position.x = clamp(lerp(position.x,get_global_mouse_position().x - $"ColorRect".get_rect().size.x / 2,.1),0,get_viewport_rect().size.x)
	for i in $Area2D.get_overlapping_bodies():
		if(i.name.contains("Enemy")):
			i.queue_free()
	
	move_and_slide()
