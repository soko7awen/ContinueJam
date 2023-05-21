extends Node2D


var rng = RandomNumberGenerator.new()
var xMin
var xMax
var timer := Timer.new()
var score = 0

func _ready():
	xMin = get_viewport_rect().size.x / 16
	xMax = get_viewport_rect().size.x - 20
	enemyTimer()
	
func enemyTimer():
	add_child(timer)
	timer.timeout.connect(spawnEnemy)
	timer.wait_time = 2
	timer.start()

func spawnEnemy():
	var number = RandomNumberGenerator.new().randi_range(1, 4)
	var Enemy
	if(number == 1):
		Enemy = preload("res://melee_enemy.tscn")
	elif(number == 2):
		Enemy = preload("res://bouncing_enemy.tscn")
	elif(number == 3):
		Enemy = preload("res://flying_enemy.tscn")
	else:
		Enemy = preload("res://rock_enemy.tscn")
	var ene = Enemy.instantiate()
	ene.position = Vector2(rng.randi_range(xMin, xMax), -100)
	$SubViewport.add_child(ene)
	timer.wait_time = RandomNumberGenerator.new().randf_range(0.2, 1.5)
	timer.start()
	
func _input(event):
	if event.is_action_pressed("death"):
		for i in 100:
			spawnEnemy();

func _on_score_changed(s):
	score += s
	$CanvasLayer/Score/Count.text = str(score).pad_zeros(3)
