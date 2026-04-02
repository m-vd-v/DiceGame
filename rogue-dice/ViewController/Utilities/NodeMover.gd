class_name NodeMover extends Node2D

@export var node_move_time: float = 0.2

@export var tween_ease: Tween.EaseType = Tween.EASE_IN_OUT
@export var tween_transition: Tween.TransitionType = Tween.TRANS_CUBIC

@export_enum("position", "global_position") var position_type: String = "position"

## moves a given node to a given position
func move_node(
			node: Node, aim_pos: Vector2,
			time: float = node_move_time,
			tw_ease: Tween.EaseType = tween_ease,
			tw_trans: Tween.TransitionType = tween_transition
		) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(
		node, position_type, 
		aim_pos,
		time
	).set_ease(tw_ease).set_trans(tw_trans)
	await tween.finished

## Pulls a node to the center of the NodeMover
func pull_node(node: Node) -> void:
	await move_node(node, Vector2(0, 0))

## Pulls a child (default index == 0) to the center of the NodeMover
func pull_child(idx: int = 0) -> void:
	if idx < 0 or idx >= get_child_count():
		return
	await move_node(get_child(idx), Vector2(0, 0))
## Pulls all children to the center of the NodeMover
func pull_children() -> void:
	for i in get_child_count():
		await move_node(get_child(i), Vector2(0, 0))

## Moves a child node to aim_pos
func move_child_node(aim_pos: Vector2, idx: int = 0) -> void:
	await move_node(get_child(idx), aim_pos)
