extends Control

var label: Label

func _ready() -> void:
	label = get_child(1)
	label.text = "0"

func _on_h_slider_value_changed(value: float) -> void:
	label.text = str(value)
