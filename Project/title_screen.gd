extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _input(event):
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://main.tscn")
	elif event is InputEventMouseButton && 0<get_global_mouse_position().y && get_global_mouse_position().y<get_viewport_rect().size.y:
		get_tree().change_scene_to_file("res://main.tscn")
