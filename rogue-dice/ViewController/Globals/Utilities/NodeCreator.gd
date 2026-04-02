class_name NodeCreator

static func create_die_node(die: Die, parent: Node = null) -> DieNode:
	var die_node_pck: PackedScene = load(
		"res://ViewController/Dice/die_node.tscn"
	)
	var die_node: DieNode = die_node_pck.instantiate()
	die_node.die = die
	if parent != null:
		parent.add_child(die_node)
	return die_node

static func create_figurine_node(
			fig: Figurine, parent: Node = null
		) -> FigurineNode:
	var fig_node_pck: PackedScene = load(
		"res://ViewController/Figurines/figurine_node.tscn"
	)
	var fig_node: FigurineNode = fig_node_pck.instantiate()
	fig_node.call_deferred("update_figurine", fig)
	if parent != null:
		parent.add_child(fig_node)
	return fig_node
