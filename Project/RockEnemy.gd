extends CharacterBody2D

const fallSpeed = 225

var isFalling = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var shootTimer = 300
var rng = RandomNumberGenerator.new()

func _ready():
	pass

func _physics_process(delta):
	if position.y > get_viewport_rect().size.y*.75:
		set_collision_mask_value(2,true)
	if(isFalling):
		velocity.y = fallSpeed
		if(is_on_floor()):
			isFalling = false
	else:
		velocity.y += gravity * delta
		if(shootTimer <= 0):
			var Enemy = preload("res://bullet.tscn")
			var ene = Enemy.instantiate()
			ene.position = position
			get_tree().get_root().get_node("Main/SubViewport").add_child(ene)
			shootTimer = 300
		else:
			shootTimer -= 1
	move_and_slide()
