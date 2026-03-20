class_name DieValueSquare extends Control

@export var label: Label

func apply_highlight(value: bool) -> void:
	$CenterContainer/ColorRect/HighLight.visible = value
	if value:
		label.modulate = Color.WHITE
		label.label_settings = label.label_settings.duplicate()
		label.label_settings.set_outline_size(5)
	else:
		label.modulate = Color.BLACK
		label.label_settings.set_outline_size(0)

func set_value(value: int, highlight: bool) -> void:
	label.text = str(value)
	apply_highlight(highlight)
