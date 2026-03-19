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

func _after_score(die_node: DieNode,
			dice_scored_before: Array[DieNode], dice_scored_after: Array[DieNode]
		) -> void:
	pass

func _on_gain_temp_bonus(die_node: DieNode, gain_amt: int) -> void:
	pass

func _on_gain_perm_bonus(die_node: DieNode, gain_amt: int) -> void:
	pass

func _after_scoring_done(die_node: DieNode, 
			all_die_nodes_scored: Array[DieNode]
		) -> void:
	pass
