class_name FigurineEmperorPenguin extends Figurine

func get_title() -> String:
	return "Emperor Penguin"
func get_description() -> String:
	return (
		"The first scored die is scored again."
	)
func get_texture() -> Texture:
	return load(
		"res://Assets/Images/Sprites/DieModifiers/DragonCrash.png"
	)

func _on_before_score_die(
			dice_scorer: DiceScorer, current_die_node: DieNode,
			can_rescore: bool
		) -> void:
	if not can_rescore:
		return
	if not dice_scorer.prev_dice.is_empty():
		return
	updated.emit("Score first die again!")
	await dice_scorer.rescore_die(current_die_node)
