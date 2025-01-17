extends VBoxContainer

@export var line_edit_strength: LineEdit
@export var line_edit_speed: LineEdit

@export var label_defense: Label
@export var label_healthmax: Label

#T0DO : change connect and callable with signals (also in other 2 scripts)

func _ready() -> void: 	
	line_edit_strength.connect("text_changed", Callable(self, "_on_line_edit_text_changed"))
	line_edit_speed.connect("text_changed", Callable(self, "_on_line_edit_text_changed"))
	
	call_deferred("update_defense_and_health")

func _on_line_edit_text_changed(_new_text):
	update_defense_and_health()

func update_defense_and_health() -> void:
	var num_strength = line_edit_strength.text.to_int() if line_edit_strength.text.is_valid_int() else 0
	var num_speed = line_edit_speed.text.to_int() if line_edit_speed.text.is_valid_int() else 0
	
	var defense = 10 + num_strength + num_speed
	var healthmax = 10 + num_strength

	label_defense.text = str(defense)
	label_healthmax.text = "/" + str(healthmax)
