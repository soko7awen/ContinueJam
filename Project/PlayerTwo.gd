extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const IFRAMES = 90

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lives = 3;
var invincibilityTimer = 0;

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("player2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("player2_left", "player2_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	for i in $Area2D.get_overlapping_bodies():
		if(i.name.contains("Enemy") && invincibilityTimer <= 0):
			takeDamage()
		elif invincibilityTimer == 0:
			$AnimationPlayer.stop()
		
	move_and_slide()
	invincibilityTimer -= 1;
	
func takeDamage():
	if lives > 1:
		lives -= 1
	else:
		lives -= 1
		get_tree().change_scene_to_file("res://game_over.tscn")
	invincibilityTimer = IFRAMES
	$AnimationPlayer.play("Blink")
	var livesUI = $"/root/Main/CanvasLayer/HeartContainer".get_children()
	livesUI[lives].texture = load("res://assets/heartEmpty.png")
	
