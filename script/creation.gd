extends Control

const SAVE_FILE_PATH = "user://save.txt"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	#call_deferred("_change_scene")

func _change_scene():
	get_tree().change_scene_to_file("res://menu2.tscn")


func _on_create_pressed() -> void:
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var data = {}
	for node in save_nodes:
		if node is LineEdit or node is OptionButton:
			data[node.name] = node.text
	
	var json_string = JSON.stringify(data)
	var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_file.store_line(json_string)
	save_file.close()
	
	call_deferred("_change_scene")
