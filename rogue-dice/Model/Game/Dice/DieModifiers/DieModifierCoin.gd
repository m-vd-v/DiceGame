class_name DieModifierCoin extends DieModifier

func get_title() -> String:
	return "Coin"
func get_description() -> String:
	return "After scoring, you gain money equal to the dice's face value (no bonus)."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Coin.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _after_reroll(_die_node: DieNode) -> void: pass

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
	GameManager.money += die_node.die.get_current_face_value()
	await die_node.do_highlight_animation()
