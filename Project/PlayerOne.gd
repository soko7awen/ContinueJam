extends CharacterBody2D

var stunTimer = 0
signal scoreChanged(score)

func _physics_process(_delta):
	if(stunTimer <= 0):
		var mouseCntr = get_global_mouse_position().x - $"Sprite2D".get_rect().size.x / 2
		$Blink.play("RESET")
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
			if(i.name.contains("Bullet")):
				stunTimer = 90
				$Blink.play("Blink")
	stunTimer -= 1
	move_and_slide()
