class_name DieModifierRecycle extends DieModifier

var used: bool = false

func get_title() -> String:
	return "Recycle"
func get_description() -> String:
	return "If this die rolls its lowest value, you gain +1 reroll. (Once per battle)"
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Recycle.png")

func _on_start_battle(_die_node: DieNode) -> void:
	used = false

func _after_reroll(die_node: DieNode) -> void:
	var die: Die = die_node.die
	var min_value_idx: int = die.faces.find( die.get_faces().min() )
	if die.current_face == min_value_idx:
		if used:
			die_node.say("Already added a reroll!")
			return
		die_node.say("+1 reroll!")
		GameManager.reroll_amt += 1
		used = true
