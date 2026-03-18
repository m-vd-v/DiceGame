class_name DieTypePermabonus extends DieType

func score(
	die_node: DieNode, die: Die, old_score: int,
	_previous_dice: Array[DieNode], next_dice: Array[DieNode]
) -> int:
	var value: int = die.get_current_value_with_bonus()
	die_node.say(str(value) + " permanent value to next die.")
	next_dice[0].add_perm_bonus(value)
	die_node.add_perm_bonus(value)
	return old_score

func get_color() -> Color:
	return Color(0.535, 0.443, 0.75, 1.0)

func get_title() -> String:
	return "Permabonus"
func get_description() -> String:
	return ("Reduces its own Permanent Bonus by its value " +
	"and gives it to the next die.")
