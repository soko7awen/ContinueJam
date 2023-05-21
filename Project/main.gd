extends Node2D

const blockShapes = ["iPiece","oPiece","tPiece","jPiece","lPiece","sPiece","zPiece"]
var rng = RandomNumberGenerator.new()
var xMin
var xMax
var spawnTimer := Timer.new()
var uniqueTimer = 300
var score = 0

func _ready():
	xMin = get_viewport_rect().size.x / 16
	xMax = get_viewport_rect().size.x - 20
	startTimer()
	
func _physics_process(delta):
	uniqueTimer -= 1
	
func startTimer():
	add_child(spawnTimer)
	spawnTimer.timeout.connect(spawn)
	spawnTimer.wait_time = 2
	spawnTimer.start()

func spawn():
	var toSpawn = RandomNumberGenerator.new().randi_range(1, 5)
	if(uniqueTimer > 0 || toSpawn <= 3):
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
	elif(toSpawn == 4):
		spawnBlock()
		uniqueTimer = 300
	else:
		spawnPower()
		uniqueTimer = 300
	spawnTimer.wait_time = RandomNumberGenerator.new().randf_range(0.2, 1.5)
	spawnTimer.start()

func spawnBlock():
	var num = RandomNumberGenerator.new().randi_range(0, 6)
	var blockInstance = load("res://blocks/" + blockShapes[num] + ".tscn").instantiate()
	blockInstance.position = Vector2(rng.randi_range(xMin, xMax), -100)
	$SubViewport.add_child(blockInstance)
	
func spawnPower():
	var power = preload("res://death_pu.tscn").instantiate
	power.position = Vector2(rng.randi_range(xMin, xMax), -100)
	$SubViewport.add_child(power)
	
func _input(event):
	if event.is_action_pressed("death"):
		for i in 100:
			spawn();

func _on_score_changed(s):
	score += s
	$CanvasLayer/Score/Count.text = str(score).pad_zeros(3)
