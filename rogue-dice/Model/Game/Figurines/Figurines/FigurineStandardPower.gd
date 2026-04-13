class_name FigurineStandardPower extends Figurine

func get_title() -> String:
	return "Standard Power"
func get_description() -> String:
	return (
		"Standard dice (not Standard+) gain +2 Permanent Bonus before scoring."
	)
func get_texture() -> Texture:
	return load(
		"res://Assets/Images/Sprites/Figurines/StandardPower.png"
	)

func _on_before_score_die(
		_dice_scorer: DiceScorer,
		current_die_node: DieNode,
		_can_rescore: bool
		) -> void:
	if current_die_node.die.type is not DieTypeStandard:
		return
	current_die_node.add_perm_bonus(+2)
	updated.emit("+2 to standard die!")
