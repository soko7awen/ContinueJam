extends Node2D

var Enemy = preload("res://melee_enemy.tscn")

func _ready():
	var xMin = get_viewport_rect().size.x / 16
	var xMax = get_viewport_rect().size.x - 20

func _process(_delta):
	spawnEnemy()

func _on_game_over():
	print("game over")

func spawnEnemy():
	var ene = Enemy.instantiate()
	$SubViewport.add_child(ene)
