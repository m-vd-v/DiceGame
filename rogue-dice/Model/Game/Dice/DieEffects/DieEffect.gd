@abstract class_name DieEffect extends Resource

@abstract func get_title() -> String
@abstract func get_description() -> String
@abstract func get_icon() -> Texture

func _on_start_battle(die_node: DieNode) -> void:
	pass

func _replace_roll(die_node: DieNode) -> void:
	pass

func _after_reroll(die_node: DieNode) -> void:
	pass

func _after_score(die_node: DieNode, dice_scorer: DiceScorer) -> void:
	pass

func _on_gain_temp_bonus(die_node: DieNode, gain_amt: int) -> void:
	pass

func _on_gain_perm_bonus(die_node: DieNode, gain_amt: int) -> void:
	pass

func _after_scoring_done(die_node: DieNode, 
			all_die_nodes_scored: Array[DieNode]
		) -> void:
	pass

func _after_battle(_die_node: DieNode) -> void: pass

func modify_die_weight(old_weight: int) -> int:
	return old_weight
	
