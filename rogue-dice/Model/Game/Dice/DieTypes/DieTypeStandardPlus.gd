class_name DieTypeStandardPlus extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], _next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus() * 2
	die_node.say("+ " + str(value))
	return old_score + value

func get_color() -> Color:
	return Color(0.331, 0.672, 0.87, 1.0)

func get_title() -> String:
	return "Standard+"
func get_description() -> String:
	return "Adds double its value to score."
