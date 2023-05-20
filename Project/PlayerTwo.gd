extends CharacterBody2D

const SPEED = 350.0
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
		if(i.name.contains("MeleeEnemy") && invincibilityTimer <= 0):
			takeDamage()
		
	move_and_slide()
	invincibilityTimer -= 1;
	
func takeDamage():
	lives -= 1
	invincibilityTimer = IFRAMES
	var livesUI = $"/root/Main/CanvasLayer/HBoxContainer".get_children()
	livesUI[lives].frame = 1
	
