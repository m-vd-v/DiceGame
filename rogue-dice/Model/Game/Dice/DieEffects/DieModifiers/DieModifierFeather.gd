class_name DieModifierFeather extends DieModifier

func get_title() -> String:
	return "Feather"
func get_description() -> String:
	return "Reduces this die's weight by 1. (minimum of 1)"
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Feather.png")

func modify_die_weight(old_weight: int) -> int:
	return old_weight - 1
