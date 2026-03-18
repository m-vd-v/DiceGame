class_name DieModifierRecycle extends DieModifier

func get_title() -> String:
	return "Recycle"
func get_description() -> String:
	return "If this die rolls its lowest value, you gain +1 reroll."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Recycle.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _after_reroll(die_node: DieNode) -> void:
	var die: Die = die_node.die
	var min_value_idx: int = die.faces.find( die.get_faces().min() )
	if die.current_face == min_value_idx:
		GameManager.reroll_amt += 1

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
