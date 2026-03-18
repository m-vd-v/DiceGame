class_name DieModifierPrism extends DieModifier

func get_title() -> String:
	return "Prism"
func get_description() -> String:
	return "After scoring, gives half its temporary bonus to the next die."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Prism.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _after_reroll(die_node: DieNode) -> void:
	pass

func _after_score(die_node: DieNode,
			_dice_scored_before: Array[DieNode], dice_scored_after: Array[DieNode]
		) -> void:
	if dice_scored_after.is_empty():
		return
	dice_scored_after[0].add_temp_bonus(
		int(float(die_node.die.temporary_bonus) / 2)
	)

func _on_gain_temp_bonus(_die_node: DieNode, gain_amt: int) -> void:
	pass

func _on_gain_perm_bonus(die_node: DieNode, gain_amt: int) -> void:
	pass

func _after_scoring_done(die_node: DieNode, 
			all_die_nodes_scored: Array[DieNode]
		) -> void:
	pass
