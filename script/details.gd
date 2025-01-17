extends Control

const utils = preload("res://script/utils.gd")
const PATH_FILE_PATH = "res://json/path_details.json"
const ANCESTRY_FILE_PATH = "res://json/ancestry_details.json"
const PATH_CHILD = 0
const ANCESTRY_CHILD = 1

func _ready() -> void:
	update_rich_text_labels(self, -1)

func _on_details_path_toggled(toggled_on: bool) -> void:
	on_details_toggled(toggled_on, PATH_CHILD)

func _on_details_ancestry_toggled(toggled_on: bool) -> void:
	on_details_toggled(toggled_on, ANCESTRY_CHILD)
	
func on_details_toggled(toggled_on: bool, child: int) -> void:
	get_child(child).visible = toggled_on
	if toggled_on:
		size_flags_vertical = SIZE_EXPAND_FILL
	else:
		size_flags_vertical = SIZE_FILL

func _on_path_item_selected(index: int) -> void:
	update_rich_text_labels(get_child(PATH_CHILD), index)

func _on_ancestry_item_selected(index: int) -> void:
	update_rich_text_labels(get_child(ANCESTRY_CHILD), index)
	
func update_rich_text_labels(node: Node, id: int) -> void:
	if node is RichTextLabel:
		if id == -1:
			node.text = ""
		else:
			node.text = get_path_text_for_id(id)
		return
	
	for child in node.get_children():
		update_rich_text_labels(child, id)

func get_path_text_for_id(node_id: int) -> String:
	var node_data = utils.load_json_from_path(PATH_FILE_PATH)
	if node_data.is_empty():
		return ""
	
	return node_data[str(node_id)]
