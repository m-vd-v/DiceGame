class_name DieModifierPrism extends DieModifier

func get_title() -> String:
	return "Prism"
func get_description() -> String:
	return "After scoring, gives half its temporary bonus to the next die."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Prism.png")

func _after_score(dice_scorer: DiceScorer) -> void:
	var dice_scored_after: Array[DieNode] = dice_scorer.next_dice
	if dice_scored_after.is_empty():
		return
	dice_scored_after[0].add_temp_bonus(
		int(float(die_node.die.temporary_bonus) / 2)
	)
