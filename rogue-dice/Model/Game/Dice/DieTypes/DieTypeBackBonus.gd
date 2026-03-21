class_name DieTypeBackBonus extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	previous_dice: Array[DieNode], _next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	await die_node.say("Previous Dice + " + str(value))
	for prev_die_node in previous_dice:
		prev_die_node.add_temp_bonus( value )
	return old_score

func get_color() -> Color:
	return Color(0.815, 0.588, 0.84, 1.0)

func get_title() -> String:
	return "Back Bonus"
func get_description() -> String:
	return "Adds the value of this die to all previous dice as Temporary Value."
