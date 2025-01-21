extends Control

const utils = preload("res://script/utils.gd")
const SAVE_FILE_PATH = "user://save.txt"

var previous_data = {}

func _ready() -> void:
	load_text()

func _on_timer_timeout() -> void:
	save_text()

func save_text() -> void:
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

func load_text() -> void:
	var node_data = get_saved_data()
	if node_data == {}:
		return
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if (node is LineEdit or node is Label) and node.name in node_data:
			node.text = node_data[node.name]
			
static func get_saved_data() -> Dictionary:
	return utils.load_json_from_path(SAVE_FILE_PATH)
