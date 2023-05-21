extends Node2D

const blockShapes = ["iPiece","oPiece","tPiece","jPiece","lPiece","sPiece","zPiece"]
var rng = RandomNumberGenerator.new()
var xMin
var xMax
var enemyTimer := Timer.new()
var blockTimer := Timer.new()
var score = 0

func _ready():
	xMin = get_viewport_rect().size.x / 16
	xMax = get_viewport_rect().size.x - 20
	startEnemyTimer()
	startBlockTimer()
	
func startEnemyTimer():
	add_child(enemyTimer)
	enemyTimer.timeout.connect(spawnEnemy)
	enemyTimer.wait_time = 2
	enemyTimer.start()

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
	enemyTimer.wait_time = RandomNumberGenerator.new().randf_range(0.2, 1.5)
	enemyTimer.start()
	
func startBlockTimer():
	add_child(blockTimer)
	blockTimer.timeout.connect(spawnBlock)
	blockTimer.wait_time = 2
	blockTimer.start()

func spawnBlock():
	var num = RandomNumberGenerator.new().randi_range(0, 6)
	var blockInstance = load("res://blocks/" + blockShapes[num] + ".tscn").instantiate()
	blockInstance.position = Vector2(rng.randi_range(xMin, xMax), -100)
	$SubViewport.add_child(blockInstance)
	blockTimer.wait_time = RandomNumberGenerator.new().randf_range(0.2, 1.5)
	blockTimer.start()
	
func _input(event):
	if event.is_action_pressed("death"):
		for i in 100:
			spawnEnemy();

func _on_score_changed(s):
	score += s
	$CanvasLayer/Score/Count.text = str(score).pad_zeros(3)
