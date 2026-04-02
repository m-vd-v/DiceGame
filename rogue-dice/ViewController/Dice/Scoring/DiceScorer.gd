class_name DiceScorer

var current_score: int = 0
var score_update_signal: Signal

var prev_dice: Array[DieNode] = []
var next_dice: Array[DieNode] = []

var current_hand_type: Hands.Type

func _init(_score_update_signal: Signal, score: int = 0) -> void:
	score_update_signal = _score_update_signal
	current_score = score

func score_dice(
			die_nodes: Array[DieNode],
		) -> void:
	current_hand_type = GameManager.hands.get_hand_type_from_die_nodes(
		die_nodes
	)
	for i in die_nodes.size():
		var die_node: DieNode = die_nodes[i]
		prev_dice = die_nodes.slice(0, i)
		next_dice = die_nodes.slice(i+1, 9999)
		await score_die(die_node)
	current_score = int(current_score * current_hand_type.multiplier)
	score_update_signal.emit(current_score)

func score_die(die_node: DieNode, can_rescore: bool = true) -> void:
	await GameManager.figurine_manager._on_before_score_die(
		self, die_node, can_rescore)
	var die: Die = die_node.die
	await die_node.do_highlight_animation(0.2)
	current_score = await die.type.score(
		die_node, die, current_score,
		prev_dice, next_dice
	)
	for effect: DieEffect in die.get_die_effects():
		await effect._after_score(self, can_rescore)
	die_node.set_die_temp_bonus(0)
	score_update_signal.emit(current_score)
	await die_node.get_tree().create_timer(0.25).timeout

func rescore_die(die_node: DieNode) -> void:
	await score_die(die_node, false)
