class_name DieModifierSnowball extends DieModifier

func get_title() -> String:
	return "Snowball"
func get_description() -> String:
	return "+2 Temporary Bonus whenever this die is rerolled."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Snowball.png")

func _after_reroll() -> void:
	die_node.add_temp_bonus(2)
	die_node.update_die_nr()
