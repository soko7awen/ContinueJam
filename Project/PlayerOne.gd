extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal scoreChanged(score)

func _physics_process(_delta):
	var mouseCntr = get_global_mouse_position().x - $"Sprite2D".get_rect().size.x / 2
	if position.x-mouseCntr>0:
		$Sprite2D.flip_h = true
	elif position.x-mouseCntr<0:
		$Sprite2D.flip_h = false
	position.x = clamp(lerp(position.x,mouseCntr,.1),0,get_viewport_rect().size.x)

	for i in $Area2D.get_overlapping_bodies():
		if(i.name.contains("Enemy")):
			i.queue_free()
			if i.name.contains("MeleeEnemy"):
				scoreChanged.emit(1)
			elif i.name.contains("BounceEnemy"):
				scoreChanged.emit(5)
			elif i.name.contains("FlyingEnemy"):
				scoreChanged.emit(10)
	move_and_slide()
