extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _input(event):
	if event.is_action_type() || event is InputEventKey:
		get_tree().change_scene_to_file("res://main.tscn")
