extends Control

@export var line_edit_level: LineEdit
@export var line_edit_strength: LineEdit
@export var line_edit_willpower: LineEdit

const utils = preload("res://script/utils.gd")
const SAVE_FILE_PATH = "user://save.txt"
const LEVEL_FILE_PATH  = "res://json/char_level.json"

func _ready() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	#call_deferred("change_scene")

func _on_create_pressed() -> void:
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var data = {}
	for node in save_nodes:
		if node is LineEdit or node is OptionButton:
			data[node.name] = node.text
	
	data = init_ressources(data)
	
	var json_string = JSON.stringify(data)
	var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_file.store_line(json_string)
	save_file.close()
	
	call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://creationSkills.tscn")

func init_ressources(data: Dictionary) -> Dictionary:
	var level_data = utils.load_json_from_path(LEVEL_FILE_PATH)
	var level_key = line_edit_level.text
	var health_gained_str_mul = level_data[level_key]["health_gained_str_mul"]
	var health_gained_flat = level_data[level_key]["health_gained_flat"]
	var healthMax = utils.get_num(line_edit_strength.text) * health_gained_str_mul + health_gained_flat
	data["HealthMax"] = "/"+str(healthMax)
	data["Health"] = str(healthMax)

	var focusMax = 2 + utils.get_num(line_edit_willpower.text)
	data["FocusMax"] = "/"+str(focusMax)
	data["Focus"] = str(focusMax)

	data["InvestitureMax"] = "/0"
	data["Investiture"] = "0"
		
	return data
