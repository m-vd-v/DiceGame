class_name DiceHolderHolder extends Node2D

signal updated_score(score: int)

@export var dice_holders: Array[DiceHolder] = []

func _ready() -> void:
	if dice_holders.is_empty():
		for child in get_children():
			if child is DiceHolder:
				dice_holders.append(child)
	update()
	update_buttons()

func count_score() -> void:
	var dice_nodes: Array[DieNode] = []
	for dh: DiceHolder in dice_holders:
		if dh.current_die != null:
			dice_nodes.append(dh.current_die)
	await DiceScorer.score_dice(dice_nodes, updated_score)
	await get_tree().create_timer(2).timeout
	for dh: DiceHolder in dice_holders:
		dh.kick_die()
		

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
	if die1 != null:
		dh1.remove_die(die1)
	if die2 != null:
		dh2.remove_die(die2)
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
