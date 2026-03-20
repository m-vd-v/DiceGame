@abstract class_name DieEffect extends Resource

@abstract func get_title() -> String
@abstract func get_description() -> String
@abstract func get_icon() -> Texture

func _on_start_battle(_die_node: DieNode) -> void:
	pass

func _replace_roll(_die_node: DieNode) -> void:
	pass

func _after_reroll(_die_node: DieNode) -> void:
	pass

func _after_score(_die_node: DieNode, _dice_scorer: DiceScorer) -> void:
	pass

func _on_gain_temp_bonus(_die_node: DieNode, _gain_amt: int) -> void:
	pass

func _on_gain_perm_bonus(_die_node: DieNode, _gain_amt: int) -> void:
	pass

func _after_scoring_done(_die_node: DieNode, 
			_all_die_nodes_scored: Array[DieNode]
		) -> void:
	pass

func _after_battle(_die_node: DieNode) -> void: pass

func modify_die_weight(old_weight: int) -> int:
	return old_weight
	
