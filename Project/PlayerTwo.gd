extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const IFRAMES = 90

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lives = 3;
var invincibilityTimer = 0;
var attackTimer = 0;

signal scoreChanged(score)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("player2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("player2_left", "player2_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED*.1)
	if direction == -1:
		$Sprite2D.flip_h = true
	if direction == 1:
		$Sprite2D.flip_h = false
	
	for i in $Area2D.get_overlapping_bodies():
		if(attackTimer >= 0):
			if(i.name.contains("Enemy")):
					i.queue_free()
					scoreChanged.emit(5)
		elif(i.name.contains("Enemy") && invincibilityTimer <= 0):
			takeDamage()
		if invincibilityTimer == 0:
			$Blink.play("RESET")
		if(i.name.contains("death")):
			for j in get_parent().get_children():
				if(j.name.contains("Enemy")):
					j.queue_free()
					scoreChanged.emit(2)
			i.queue_free()
		if(i.name.contains("attack")):
			i.queue_free()
			attackTimer = 420
	move_and_slide()
	invincibilityTimer -= 1
	attackTimer -= 1
	
func takeDamage():
	if lives > 1:
		lives -= 1
	else:
		lives -= 1
		get_tree().change_scene_to_file("res://game_over.tscn")
	invincibilityTimer = IFRAMES
	$Blink.play("Blink")
	var livesUI = $"/root/Main/CanvasLayer/HeartContainer".get_children()
	livesUI[lives].texture = load("res://assets/heartEmpty.png")
	
