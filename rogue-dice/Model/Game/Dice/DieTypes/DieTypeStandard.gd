class_name DieTypeStandard extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], _next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	await die_node.say("+ " + str(value))
	return old_score + value

func get_color() -> Color:
	return Color(0.618, 0.777, 0.87, 1.0)

func get_title() -> String:
	return "Standard"
func get_description() -> String:
	return "Adds its value to score."
