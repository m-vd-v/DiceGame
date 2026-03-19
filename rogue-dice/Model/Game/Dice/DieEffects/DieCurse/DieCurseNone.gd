class_name DieCurseNone extends DieCurse

func get_title() -> String:
	return "No Curse"
func get_description() -> String:
	return "-"
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/None.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _replace_roll(die_node: DieNode) -> void: pass

func _after_reroll(die_node: DieNode) -> void:
	pass

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
