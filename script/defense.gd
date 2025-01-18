extends VBoxContainer

@export var label_attribute1: Label
@export var label_attribute2: Label
@export var label_defense: Label

func _ready() -> void: 	
	call_deferred("update_defense")

func update_defense() -> void:
	var num_attribute1 = label_attribute1.text.to_int() if label_attribute1.text.is_valid_int() else 0
	var num_attribute2 = label_attribute2.text.to_int() if label_attribute2.text.is_valid_int() else 0
	
	var defense = 10 + num_attribute1 + num_attribute2

	label_defense.text = str(defense)
