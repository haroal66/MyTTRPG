extends VBoxContainer

@export var line_edit_awareness: LineEdit
@export var line_edit_presence: LineEdit

@export var label_defense: Label

func _ready() -> void: 
	line_edit_awareness.connect("text_changed", Callable(self, "_on_line_edit_text_changed"))
	line_edit_presence.connect("text_changed", Callable(self, "_on_line_edit_text_changed"))
	
	call_deferred("update_defense")

func _on_awareness_text_changed(_new_text: String) -> void:
	update_defense()

func _on_presence_text_changed(_new_text: String) -> void:
	update_defense()

func update_defense()-> void:
	var num_awareness = line_edit_awareness.text.to_int() if line_edit_awareness.text.is_valid_int() else 0
	var num_presence = line_edit_presence.text.to_int() if line_edit_presence.text.is_valid_int() else 0
	
	var defense = 10 + num_awareness + num_presence

	label_defense.text = str(defense)
