@abstract class_name DieType extends Resource

@abstract func score(
	die_node: DieNode, die: Die, old_score: int,
	previous_dice: Array[DieNode], next_dice: Array[DieNode]
) -> int

@abstract func get_color() -> Color

@abstract func get_title() -> String
@abstract func get_description() -> String

func get_base_weight() -> int:
	return 2
