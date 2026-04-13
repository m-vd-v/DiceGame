class_name SidebarBattleNode extends SideBar

@export var dice_holder_holder: DiceHolderHolder
@export var score_label: Label

@onready var battle_panel: RoadmapPanelBattle = panel

func _ready() -> void:
	await sidebar_bg.after_slide_into_view
	start_battle()

func update_score(score: int = 0) -> void:
	score_label.text = (
		"Score: " + str(score) +
		"/" + str(battle_panel.battle.req_score)
	)
	var current_hand: Hands.Type = GameManager.hands.get_hand_type_from_die_nodes(
		dice_holder_holder.get_dice_nodes()
	)
	%HandLabel.text = (
		"Current Hand: " + current_hand.name +
		"\nMultiplier: " + str(current_hand.multiplier) + "x"
	)
	%BossDescription.text = battle_panel.battle.boss.get_description()

func _on_score_button_pressed() -> void:
	await dice_holder_holder.count_score()
	var dice_holders: Array[DiceHolder] = dice_holder_holder.get_full_dice_holders()
	for dh: DiceHolder in dice_holders:
		if dh == dice_holders.back():
			await dh.kick_die()
		else:
			dh.kick_die()
	if battle_panel.battle.has_won():
		end_battle()
	else:
		GameManager.lives -= 1
		GameManager.reroll_amt = GameManager.max_rerolls

func start_battle() -> void:
	update_sidebar()
	GameManager.reroll_amt = GameManager.max_rerolls
	update_score(0)
	await GameManager.figurine_manager._on_battle_start()
	for die_node: DieNode in GameManager.dice_manager_node.get_children():
		for effect: DieEffect in die_node.die.get_die_effects():
			await effect._on_start_battle()
	await battle_panel.battle.start()

func end_battle() -> void:
	sidebar_bg.show_next_buttons()
	GameManager.money += 3
	dice_holder_holder.queue_free()
	$SideBar/ScoreButton.queue_free()
	for die_node: DieNode in GameManager.dice_manager_node.get_children():
		for effect: DieEffect in die_node.die.get_die_effects():
			await effect._after_battle()
	GameManager.figurine_manager._on_battle_end()
	await battle_panel.battle.end()

func _on_dice_holder_holder_updated_score(score: int) -> void:
	battle_panel.battle.current_score = score
	update_score(score)



func _on_dice_holder_holder_dice_updated() -> void:
	update_score()
