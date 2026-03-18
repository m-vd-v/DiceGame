class_name DieTypeMoney extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], _next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	var pip_value: int = int(float(value) / 2)
	var money_value: int = pip_value
	if value % 2 == 1:
		pip_value += 1
	die_node.say("+ " + str(pip_value) + " & + " + str(money_value) + " money")
	return old_score + value

func get_color() -> Color:
	return Color(1.0, 0.984, 0.53, 1.0)
