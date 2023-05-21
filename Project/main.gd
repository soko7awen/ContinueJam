extends Node2D

var Enemy = preload("res://melee_enemy.tscn")
var rng = RandomNumberGenerator.new()
var xMin
var xMax

func _ready():
	xMin = get_viewport_rect().size.x / 16
	xMax = get_viewport_rect().size.x - 20
	enemyTimer()

func _physics_process(_delta):
	pass
	
func enemyTimer():
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = RandomNumberGenerator.new().randf_range(0.1, 1)
	timer.start()
	timer.timeout.connect(spawnEnemy)


func spawnEnemy():
	var ene = Enemy.instantiate()
	ene.position = Vector2(rng.randi_range(xMin, xMax), -100)
	$SubViewport.add_child(ene)
