extends Control

var tex
# Called when the node enters the scene tree for the first time.
func _ready():
	if tex:
		$Image.texture = tex
func _on_restart_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
