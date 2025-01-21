extends Control

@export var grid: GridContainer

const utils = preload("res://script/utils.gd")
const SKILL_SCENE = preload("res://scene/skill.tscn")
const SKILL_ATTRIBUTE = "res://json/skill_attribute.json"

func _ready() -> void:
	var skill_attribute = utils.load_json_from_path(SKILL_ATTRIBUTE)
	for skill in skill_attribute[name]:
		var instance = SKILL_SCENE.instantiate()
		instance.name = skill
		instance.skill_group = name
		grid.add_child(instance)
