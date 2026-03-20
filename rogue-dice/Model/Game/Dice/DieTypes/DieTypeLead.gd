class_name DieTypeLead extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], _next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	value += GameManager.dice_weight
	await die_node.say("+ " + str(value))
	return old_score + value

func get_color() -> Color:
	return Color(0.425, 0.72, 0.543, 1.0)

func get_title() -> String:
	return "Lead"
func get_description() -> String:
	return "Adds its value + the weight of all dice to score."
