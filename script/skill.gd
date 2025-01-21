extends Control

@export var label_skill: Label
@export var label_modifier: Label
@export var label_attribute: Label

const save = preload("res://script/save.gd")
const utils = preload("res://script/utils.gd")
const SKILL_ATTRIBUTE = "res://json/skill_attribute.json"
const FORMAT_ATTRIBUTE = "%s (%s)"

var skill_group: String

func _ready() -> void:
	init()
	update_modifier()

func _on_skill_value_changed(value: int) -> void:
	update_modifier(value)

func update_modifier(skill: int = 0) -> void:
	var save_data = save.get_saved_data()
	var attribute = get_attribute(name)
	var attribute_value = utils.get_num(save_data[attribute])
	var modifier = attribute_value + skill
	label_modifier.text = "+ " + str(modifier)

func init() -> void:
	label_skill.text = name
	
	var save_data = save.get_saved_data()
	var attribute = get_attribute(name)
	var attribute_value = save_data[attribute]
	label_attribute.text = FORMAT_ATTRIBUTE %[attribute, attribute_value]

func get_attribute(skill_name: String) -> String:
	var skill_attribute = utils.load_json_from_path(SKILL_ATTRIBUTE)
	return skill_attribute[skill_group][skill_name]
