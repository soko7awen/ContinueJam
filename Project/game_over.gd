extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Restart").grab_focus()
	
func _on_restart_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
