extends Node2D

var Enemy = preload("res://melee_enemy.tscn")
var rng = RandomNumberGenerator.new()
var xMin
var xMax
var timer := Timer.new()

func _ready():
	xMin = get_viewport_rect().size.x / 16
	xMax = get_viewport_rect().size.x - 20
	enemyTimer()

func _physics_process(_delta):
	pass
	
func enemyTimer():
	add_child(timer)
	timer.timeout.connect(spawnEnemy)
	timer.wait_time = 2
	timer.start()

func spawnEnemy():
	var ene = Enemy.instantiate()
	ene.position = Vector2(rng.randi_range(xMin, xMax), -100)
	$SubViewport.add_child(ene)
	timer.wait_time = RandomNumberGenerator.new().randf_range(0.2, 1.5)
	timer.start()
