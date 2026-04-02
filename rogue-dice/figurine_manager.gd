class_name FigurineManager extends NodeHolder

@export var starting_figurines: Array[FigurineNode]

func _ready() -> void:
	GameManager.figurine_manager = self
	await get_tree().create_timer(1).timeout
	for fig in starting_figurines:
		await add_figurine_node(fig)

func get_figurine_nodes() -> Array[FigurineNode]:
	var fig_nodes: Array[FigurineNode] = []
	for child in get_children():
		if child is FigurineNode:
			fig_nodes.append(child)
	return fig_nodes

func _on_battle_start() -> void:
	for fig_node: FigurineNode in get_figurine_nodes():
		await fig_node.figurine._on_battle_start()

func _on_reroll() -> void:
	for fig_node: FigurineNode in get_figurine_nodes():
		await fig_node.figurine._on_reroll()

func _on_before_score_die(
		dice_scorer: DiceScorer, die_node: DieNode, can_rescore: bool) -> void:
	for fig_node: FigurineNode in get_figurine_nodes():
		await fig_node.figurine._on_before_score_die(
			dice_scorer, die_node, can_rescore)

func _on_battle_end() -> void:
	for fig_node: FigurineNode in get_figurine_nodes():
		await fig_node.figurine._on_battle_end()

func add_figurine_node(fig_node: FigurineNode) -> void:
	var gp: Vector2 = fig_node.global_position
	fig_node.get_parent().remove_child(fig_node)
	add_child(fig_node)
	fig_node.global_position = gp
	await move_nodes()
	await fig_node.figurine._on_obtain()
