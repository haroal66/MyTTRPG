extends VBoxContainer

@export var label_health: Label
@export var label_healthmax: Label

@export var label_focus: Label
@export var label_focusmax: Label

@export var label_investiture: Label
@export var label_investituremax: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _button_plus(currentLabel : Label, maxLabel : Label) -> void:
	var newValue = currentLabel.text.to_int() + 1 if currentLabel.text.is_valid_int() else 0
	var max_text = maxLabel.text.replace("/","")
	var maxValue = max_text.to_int() if max_text.is_valid_int() else 0
	currentLabel.text = str(newValue if newValue <= maxValue else maxValue)

func _button_minus(currentLabel : Label) -> void:
	var newValue = currentLabel.text.to_int() - 1 if currentLabel.text.is_valid_int() else 0
	currentLabel.text = str(newValue if newValue >= 0 else 0)

func _on_plus_health_pressed() -> void:
	_button_plus(label_health, label_healthmax)

func _on_minus_health_pressed() -> void:
	_button_minus(label_health)
	
func _on_focus_plus_pressed() -> void:
	_button_plus(label_focus, label_focusmax)

func _on_focus_minus_pressed() -> void:
	_button_minus(label_focus)

func _on_plus_investiture_pressed() -> void:
	_button_plus(label_investiture, label_investituremax)

func _on_minus_investiture_pressed() -> void:
	_button_minus(label_investiture)
