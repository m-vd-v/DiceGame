class_name NodeHolder extends NodeMover

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT,
	FOLD,
}

@export var direction: Direction = Direction.LEFT

@export var node_size: Vector2 = Vector2(200, 100)
@export var max_length: int = 500

@export var fold_position: Vector2 = Vector2(0, 0)
@export var fold_ease: Tween.EaseType = Tween.EASE_IN_OUT
@export var fold_transition: Tween.TransitionType = Tween.TRANS_CUBIC
@export var fold_time: float = 0.2

func fold() -> void:
	await move_nodes(Direction.FOLD)

func move_nodes(
			dir: Direction = direction
		) -> void:
	var node_amt: int = get_child_count()
	var size: float
	match dir:
		Direction.LEFT, Direction.RIGHT: size = node_size.x
		Direction.UP, Direction.DOWN: size = node_size.y
		Direction.FOLD: size = 0
	var exceeds_limit: bool = (size * get_child_count() > max_length)
	
	for i in node_amt:
		var node = get_child(i)
		var aim_magnitude: float
		if exceeds_limit:
			aim_magnitude = (float(max_length) / get_child_count()) * i
		else:
			aim_magnitude = i * size
			
		var aim_pos: Vector2
		match dir:
			Direction.LEFT: aim_pos = Vector2(aim_magnitude, 0)
			Direction.RIGHT: aim_pos = Vector2(-aim_magnitude, 0)
			Direction.UP: aim_pos = Vector2(0, -aim_magnitude)
			Direction.DOWN: aim_pos = Vector2(0, aim_magnitude)
			Direction.FOLD: aim_pos = fold_position
		
		await do_move_node(node, aim_pos, (dir == Direction.FOLD), (i == node_amt-1) )

func do_move_node(
			node: Node, aim_pos: Vector2,
			do_fold: bool = false, do_await: bool = false
		) -> void:
	if do_fold:
		if do_await:
			await move_node(node, aim_pos, fold_time, fold_ease, fold_transition)
		else:
			move_node(node, aim_pos, fold_time, fold_ease, fold_transition)
	else:
		if do_await:
			await move_node(node, aim_pos)
		else:
			move_node(node, aim_pos)
	
