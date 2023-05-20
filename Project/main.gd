extends Node2D

func _ready():
	var xMin = get_viewport_rect().size.x / 16
	var xMax = get_viewport_rect().size.x - 20

func _process(delta):
	pass

func enemySpawn():
	print("bruh")
