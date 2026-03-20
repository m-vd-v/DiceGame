class_name DieTypeMultiplier extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], _next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	var mult_value: float = 1.0 + (float(value) / 10)
	await die_node.say(
		"x " + str(mult_value) +
		" (1.0 + " + str(mult_value-1) + ")"
	)
	return int(old_score * mult_value)

func get_color() -> Color:
	return Color(1.0, 0.58, 0.615, 1.0)

func get_title() -> String:
	return "Multiplier"
func get_description() -> String:
	return "Multiplies your score by 1 + (0.1 * value)."
