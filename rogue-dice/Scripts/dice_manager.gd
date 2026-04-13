class_name DiceManager extends Node2D

func _ready() -> void:
	GameManager.dice_manager_node = self

func roll_all() -> void:
	for d in get_children():
		var die: DieNode = d
		die.roll()
		
func add_die(die_node: DieNode) -> void:
	var gp: Vector2 = die_node.global_position
	die_node.get_parent().remove_child(die_node)
	add_child(die_node)
	recalculate_die_weight()
	die_node.global_position = gp
	await create_tween().tween_property(
		die_node, "position", Vector2.ZERO, 0.5
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).finished
	die_node.unlock()
	die_node.roll()

func recalculate_die_weight() -> void:
	var total_weight: int = 0
	for die_node: DieNode in get_children():
		total_weight += die_node.die.get_die_weight()
	GameManager.dice_weight = total_weight
