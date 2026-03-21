class_name DieModifierFireTornado extends DieModifier

func get_title() -> String:
	return "Fire Tornado"
func get_description() -> String:
	return "Scores an additional time."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/FireTornado.png")

func _after_score(dice_scorer: DiceScorer) -> void:
	await dice_scorer.score_die(
		die_node, false
	)
