class_name DieTypeMoney extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], _next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	var pip_value: int = int(float(value) / 2)
	var money_value: int = min(pip_value, 10)
	pip_value += value % 2
	die_node.say("+ " + str(pip_value) + " & + " + str(money_value) + " money")
	GameManager.money += money_value
	return old_score + value

func get_color() -> Color:
	return Color(1.0, 0.984, 0.53, 1.0)

func get_title() -> String:
	return "Gold"
func get_description() -> String:
	return ("Adds half of its value in score and gives half in money " + 
	"(with a maximum of 10 money).")
