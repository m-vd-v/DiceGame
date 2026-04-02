@abstract class_name DieEffect extends Resource

var die_node: DieNode

@abstract func get_title() -> String
@abstract func get_description() -> String
@abstract func get_icon() -> Texture

func _on_added_to_die_node() -> void:
	pass

func _on_start_battle() -> void:
	pass

func _replace_roll() -> void:
	pass

func _after_reroll() -> void:
	pass

func _after_score(_dice_scorer: DiceScorer, _can_rescore: bool) -> void:
	pass

func _on_gain_temp_bonus(_gain_amt: int) -> void:
	pass

func _on_gain_perm_bonus(_gain_amt: int) -> void:
	pass

func _after_scoring_done(_all_die_nodes_scored: Array[DieNode]	) -> void:
	pass

func _after_battle() -> void: pass

func modify_die_weight(old_weight: int) -> int:
	return old_weight
	
