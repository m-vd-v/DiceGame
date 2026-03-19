class_name DieModifierMirror extends DieModifier

func get_title() -> String:
	return "Mirror"
func get_description() -> String:
	return "Doubles any Bonus it receives."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Mirror.png")

func _on_gain_temp_bonus(die_node: DieNode, gain_amt: int) -> void:
	die_node.add_temp_bonus(gain_amt, false)

func _on_gain_perm_bonus(die_node: DieNode, gain_amt: int) -> void:
	die_node.add_perm_bonus(gain_amt, false)
