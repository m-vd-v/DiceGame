class_name DieTypeStandard extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], _next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	die_node.say("+ " + str(value))
	return old_score + value

func get_color() -> Color:
	return Color(0.45, 0.671, 0.79, 1.0)
