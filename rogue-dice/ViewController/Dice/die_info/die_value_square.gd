class_name DieValueSquare extends Control

func set_value(value: int) -> void:
	$CenterContainer/ColorRect/Label.text = str(value)
