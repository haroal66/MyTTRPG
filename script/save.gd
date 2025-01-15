extends Control

const SAVE_FILE_PATH = "user://save.txt"
var previous_data = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_text()

func _save_text() -> void:
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var data = {}
	for node in save_nodes:
		if node is LineEdit or node is Label:
			data[node.name] = node.text
		
	if data == previous_data:
		return
	
	var json_string = JSON.stringify(data)
	var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_file.store_line(json_string)
	save_file.close()
	
	previous_data = data

func _load_text() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	
	var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	var json_string = save_file.get_line()
	save_file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	var node_data = json.data
	for node in save_nodes:
		if (node is LineEdit or node is Label) and node.name in node_data:
			node.text = node_data[node.name]

func _on_timer_timeout() -> void:
	_save_text()
