class_name DieModifierGrow extends DieModifier

func get_title() -> String:
	return "Growing"
func get_description() -> String:
	return "After rolling, increases the face it lands on by 1."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Grow.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _after_reroll(die_node: DieNode) -> void:
	var die: Die = die_node.die
	die.faces[die.current_face] += 1
	die_node.update_die_nr()

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
