extends VBoxContainer

@export var line_edit_level: LineEdit
@export var label_points_remaining: Label

const utils = preload("res://script/utils.gd")
const LEVEL_FILE_PATH = "res://json/char_level.json"
const ATTRIBUTE_POINTS = "attribute_points"

var strength = 0
var speed = 0
var intellect = 0
var willpower = 0
var awareness = 0
var presence = 0

func _ready() -> void:
	update_point_remaining()

func _on_level_text_changed(_new_text: String) -> void:
	update_point_remaining()

func _on_strength_text_changed(new_text: String) -> void:
	strength = utils.get_num(new_text)
	update_point_remaining()

func _on_speed_text_changed(new_text: String) -> void:
	speed = utils.get_num(new_text)
	update_point_remaining()

func _on_intellect_text_changed(new_text: String) -> void:
	intellect = utils.get_num(new_text)
	update_point_remaining()

func _on_willpower_text_changed(new_text: String) -> void:
	willpower = utils.get_num(new_text)
	update_point_remaining()

func _on_awareness_text_changed(new_text: String) -> void:
	awareness = utils.get_num(new_text)
	update_point_remaining()

func _on_presence_text_changed(new_text: String) -> void:
	presence = utils.get_num(new_text)
	update_point_remaining()

func update_point_remaining() -> void:
	var level = utils.get_num(line_edit_level.text)
	var attributes_points = get_attributes_points(level)
	var points_remaining = attributes_points - strength - speed - intellect - willpower - awareness - presence
	label_points_remaining.text = str(points_remaining)

func get_attributes_points(level: int) -> int:
	var data = utils.load_json_from_path(LEVEL_FILE_PATH)
	if data.is_empty():
		return 0
	
	var level_key = str(level)
	return data[level_key][ATTRIBUTE_POINTS]
