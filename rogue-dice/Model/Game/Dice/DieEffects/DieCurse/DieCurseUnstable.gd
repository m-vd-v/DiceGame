class_name DieCurseUnstable extends DieCurse

func get_title() -> String:
	return "Unstable"
func get_description() -> String:
	return "Randomizes the die's Type on reroll."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DieCurses/Unstable.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _replace_roll(die_node: DieNode) -> void: pass

func _after_reroll(die_node: DieNode) -> void:
	die_node.die.type = DieGenerator.generate_die_type(
		[DieGenerator.Rarity.COMMON, DieGenerator.Rarity.UNCOMMON,
		DieGenerator.Rarity.RARE]
	)
	die_node.update_die_type()
