extends VBoxContainer

# Variables pour les LineEdit nodes
@export var line_edit_strength: LineEdit
@export var line_edit_speed: LineEdit
@export var line_edit_defense: LineEdit
@export var line_edit_healthmax: LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	# Connecte les signaux "text_changed" des LineEdits sources
	line_edit_strength.connect("text_changed", Callable(self, "_on_line_edit_text_changed"))
	line_edit_speed.connect("text_changed", Callable(self, "_on_line_edit_text_changed"))

func _on_line_edit_text_changed(new_text):
	# Récupère les valeurs des LineEdits
	var num_strength = line_edit_strength.text.to_int() if line_edit_strength.text.is_valid_int() else 0
	var num_speed = line_edit_speed.text.to_int() if line_edit_speed.text.is_valid_int() else 0
	
	var defense = 10 + num_strength + num_speed
	var healthmax = 10 + num_strength

	line_edit_defense.text = str(defense)
	line_edit_healthmax.text = str(healthmax)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
