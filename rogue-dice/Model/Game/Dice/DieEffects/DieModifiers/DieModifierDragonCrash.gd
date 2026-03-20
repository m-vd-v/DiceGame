class_name DieModifierDragonCrash extends DieModifier

func get_title() -> String:
	return "Drakenpoeier"
func get_description() -> String:
	return "Scores the next die an additional time."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DragonCrash.png")

func _after_score(die_node: DieNode, dice_scorer: DiceScorer) -> void:
	var next_die: DieNode = dice_scorer.next_dice[0]
	if next_die == null:
		return
	await dice_scorer.score_die(
		next_die, false
	)
