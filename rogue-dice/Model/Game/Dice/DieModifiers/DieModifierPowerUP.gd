class_name DieModifierPowerUp extends DieModifier

func get_title() -> String:
	return "Power UP"
func get_description() -> String:
	return "At the start of a battle, this die gains Temporary Bonus
	equal to its current face value."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Power-Up.png")

func _on_start_battle(die_node: DieNode) -> void:
	var die: Die = die_node.die
	die_node.add_temp_bonus(die.get_current_face_value())

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
