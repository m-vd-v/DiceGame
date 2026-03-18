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
