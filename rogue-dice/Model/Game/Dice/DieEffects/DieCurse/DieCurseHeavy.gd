class_name DieCurseHeavy extends DieCurse

func get_title() -> String:
	return "Heavy"
func get_description() -> String:
	return "Increases this die's weight by 1."
func get_icon() -> Texture:
	return load(
		"res://Assets/Images/Sprites/DieModifiers/DieCurses/Heavy.png"
	)

func modify_die_weight(old_weight: int) -> int:
	return old_weight + 1
