class_name DiceManager extends Node2D

func _ready() -> void:
	GameManager.dice_manager_node = self

func roll_all() -> void:
	for d in get_children():
		var die: DieNode = d
		die.roll()
		
func add_die(die_node: DieNode) -> void:
	recalculate_die_amt()
	var gp: Vector2 = die_node.global_position
	die_node.get_parent().remove_child(die_node)
	add_child(die_node)
	die_node.global_position = gp
	await create_tween().tween_property(
		die_node, "position", Vector2.ZERO, 0.5
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).finished
	die_node.roll()

func recalculate_die_amt() -> void:
	GameManager.dice_amt = get_child_count()
