class_name DieModifierGrow extends DieModifier

func get_title() -> String:
	return "Growing"
func get_description() -> String:
	return "After rolling, increases the face it lands on by 1."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Grow.png")

## override
func _after_reroll(die_node: DieNode) -> void:
	var die: Die = die_node.die
	die.faces[die.current_face] += 1
	die_node.update_die_nr()
