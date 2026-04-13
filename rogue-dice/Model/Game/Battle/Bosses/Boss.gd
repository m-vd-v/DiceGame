@abstract class_name Boss extends Resource

@abstract func get_title() -> String
@abstract func get_description() -> String
func get_score_requirement_multiplier() -> float:
	return 1.0

func _on_battle_start() -> void:
	pass

func _before_score_die(_die_node: DieNode, _dice_scorer: DiceScorer) -> void:
	pass

func _after_score_die(_die_node: DieNode, _dice_scorer: DiceScorer) -> void:
	pass

func _before_reroll() -> void:
	pass

func _after_reroll() -> void:
	pass

func _on_battle_end() -> void:
	pass
