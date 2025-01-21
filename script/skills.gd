extends Control

@export var label_level: Label
@export var label_points_remaining: Label
@export var rich_text_points_max: RichTextLabel

const utils = preload("res://script/utils.gd")
const LEVEL_FILE_PATH = "res://json/char_level.json"
const SKILL_POINTS = "skill_ranks"
const SKILL_MAX = "max_skill_rank"

func _ready() -> void:
	update_point_remaining()
	update_point_max()

func update_point_remaining() -> void:
	var level = utils.get_num(label_level.text)
	var skill_points = get_skills_points(level)
	var points_remaining = skill_points
	label_points_remaining.text = str(points_remaining)

func get_skills_points(level: int) -> int:
	var data = utils.load_json_from_path(LEVEL_FILE_PATH)
	if data.is_empty():
		return 0
	
	var level_key = str(level)
	return data[level_key][SKILL_POINTS]

func update_point_max() -> void:
	var level = utils.get_num(label_level.text)
	var max_points = get_max_skills_points(level)
	var format_string = "You can‘t put more than %s points into any skill at your level"
	rich_text_points_max.text = format_string % str(max_points)

func get_max_skills_points(level: int) -> int:
	var data = utils.load_json_from_path(LEVEL_FILE_PATH)
	if data.is_empty():
		return 0
	
	var level_key = str(level)
	return data[level_key][SKILL_MAX]
