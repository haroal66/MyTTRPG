extends VBoxContainer

# Variables pour les LineEdit nodes
@export var line_edit_intellect: LineEdit
@export var line_edit_willpower: LineEdit

@export var label_defense: Label
@export var label_focusmax: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	line_edit_intellect.connect("text_changed", Callable(self, "_on_line_edit_text_changed"))
	line_edit_willpower.connect("text_changed", Callable(self, "_on_line_edit_text_changed"))
	
	call_deferred("_update_defense_and_focus")

func _update_defense_and_focus()-> void:
	var num_intellect = line_edit_intellect.text.to_int() if line_edit_intellect.text.is_valid_int() else 0
	var num_willpower = line_edit_willpower.text.to_int() if line_edit_willpower.text.is_valid_int() else 0
	
	var defense = 10 + num_intellect + num_willpower
	var focusmax = 2 + num_willpower

	label_defense.text = str(defense)
	label_focusmax.text = "/" + str(focusmax)

func _on_line_edit_text_changed(_new_text):
	_update_defense_and_focus()
