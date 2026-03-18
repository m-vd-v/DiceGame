class_name DieTypeBonus extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	die_node.say("Next Die + " + str(value))
	if next_dice.is_empty():
		return old_score
	var next_die_node: DieNode = next_dice[0]
	var next_die: Die = next_die_node.die
	next_die_node.set_die_temp_bonus(
		next_die.temporary_bonus + die.get_current_value_with_bonus()
	)
	return old_score

func get_color() -> Color:
	return Color(0.783, 0.58, 1.0, 1.0)
