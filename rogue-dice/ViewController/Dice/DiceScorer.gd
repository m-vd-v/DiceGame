class_name DiceScorer

static func score_dice(
			die_nodes: Array[DieNode],
			score_update_signal: Signal
		) -> void:
	var current_score: int = 0
	for i in die_nodes.size():
		var die_node: DieNode = die_nodes[i]
		var die: Die = die_node.die
		await die_node.do_highlight_animation(0.2)
		var prev_dice: Array[DieNode] = die_nodes.slice(0, i)
		var next_dice: Array[DieNode] = die_nodes.slice(i+1, 9999)
		current_score = die.type.score(
			die_node, die, current_score,
			prev_dice,
			next_dice
		)
		die.modifier1._after_score(die_node, prev_dice, next_dice)
		die.modifier2._after_score(die_node, prev_dice, next_dice)
		die_node.set_die_temp_bonus(0)
		score_update_signal.emit(current_score)
		await die_node.get_tree().create_timer(0.25).timeout
