extends Node2D

var Enemy = preload("res://melee_enemy.tscn")
var rng = RandomNumberGenerator.new()
var xMin
var xMax

func _ready():
	xMin = get_viewport_rect().size.x / 16
	xMax = get_viewport_rect().size.x - 20
	print(xMin)
	print(xMax)

func _physics_process(_delta):
	if(rng.randf_range(0.0, 100.0) <= 0.75):
		spawnEnemy()

func spawnEnemy():
	var ene = Enemy.instantiate()
	ene.position = Vector2(rng.randi_range(xMin, xMax), -100)
	$SubViewport.add_child(ene)
