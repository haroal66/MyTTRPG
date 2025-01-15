extends Control

const SAVE_FILE_PATH = "user://save.txt"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return	
	call_deferred("_change_scene")

func _change_scene():
	get_tree().change_scene_to_file("res://menu2.tscn")
