class_name DiceHolderHolder extends Node2D

signal updated_score(score: int)

signal dice_updated

@export var dice_holders: Array[DiceHolder] = []

func _ready() -> void:
	if dice_holders.is_empty():
		for child in get_children():
			if child is DiceHolder:
				dice_holders.append(child)
				child.die_added.connect(
					func(_die_node): dice_updated.emit()
				)
				child.die_removed.connect(
					func(_dh, _die_node): dice_updated.emit()
				)
	update()
	update_buttons()

func get_dice_nodes() -> Array[DieNode]:
	var dice_nodes: Array[DieNode] = []
	for dice_holder in dice_holders:
		var die_node: DieNode = dice_holder.current_die
		if die_node != null:
			dice_nodes.append(die_node)
	return dice_nodes

func get_full_dice_holders() -> Array[DiceHolder]:
	var dhs: Array[DiceHolder] = []
	for dice_holder in dice_holders:
		if dice_holder.current_die != null:
			dhs.append(dice_holder)
	return dhs

func lock_holder_dice() -> void:
	for die_holder in dice_holders:
		if die_holder.current_die == null:
			continue
		die_holder.current_die.lock()

func count_score() -> void:
	lock_holder_dice()
	var dice_nodes: Array[DieNode] = []
	for dh: DiceHolder in dice_holders:
		if dh.current_die != null:
			dice_nodes.append(dh.current_die)
	var dice_scorer: DiceScorer = DiceScorer.new(updated_score, 0)
	await dice_scorer.score_dice(dice_nodes)
	await get_tree().create_timer(1).timeout
	for die_node in dice_nodes:
		for effect: DieEffect in die_node.die.get_die_effects():
			await effect._after_scoring_done(dice_nodes)

func update() -> void:
	for dice_holder: DiceHolder in dice_holders:
		dice_holder.swap_button_pressed.connect(pressed_swap)
		dice_holder.die_added.connect(dice_added_to_holder)

func update_buttons() -> void:
	for idx: int in dice_holders.size():
		var dh: DiceHolder = dice_holders[idx]
		dh.swap_button.visible = true
		if idx == dice_holders.size() - 1:
			dh.swap_button.visible = false

func swap_dice(dh1: DiceHolder, dh2: DiceHolder) -> void:
	var die1: DieNode = dh1.current_die
	var die2: DieNode = dh2.current_die
	var remove_lock: bool = false
	if die1 != null:
		dh1.remove_die(die1, remove_lock)
	if die2 != null:
		dh2.remove_die(die2, remove_lock)
		dh1.add_die(die2)
	if die1 != null:
		dh2.add_die(die1)

func dice_added_to_holder(_dice_holder: DiceHolder) -> void:
	update_buttons()

func pressed_swap(dice_holder: DiceHolder) -> void:
	var dh_idx: int = dice_holders.find(dice_holder)
	var below: int = dh_idx + 1
	if below >= dice_holders.size():
		return
	swap_dice(dice_holder, dice_holders[below])
