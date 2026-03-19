class_name SidebarBattleNode extends SideBar

@export var dice_holder_holder: DiceHolderHolder
@export var score_label: Label

@onready var battle_panel: RoadmapPanelBattle = panel

func _ready() -> void:
	update_sidebar()
	GameManager.reroll_amt = GameManager.max_rerolls
	update_score(0)

func update_score(score: int) -> void:
	score_label.text = (
		"Score: " + str(score) +
		"/" + str(battle_panel.battle.score)
	)

func _on_score_button_pressed() -> void:
	await dice_holder_holder.count_score()
	if battle_panel.battle.has_won():
		sidebar_bg.show_next_buttons()
		GameManager.money += 3
		for dh: DiceHolder in dice_holder_holder.dice_holders:
			if dh == dice_holder_holder.dice_holders.back():
				await dh.kick_die()
			else:
				dh.kick_die()
		dice_holder_holder.queue_free()
		$SideBar/ScoreButton.queue_free()
		for die_node: DieNode in GameManager.dice_manager_node.get_children():
			for effect: DieEffect in die_node.die.get_die_effects():
				effect._after_battle(die_node)
	else:
		GameManager.lives -= 1
		GameManager.reroll_amt = GameManager.max_rerolls
	
func _on_dice_holder_holder_updated_score(score: int) -> void:
	battle_panel.battle.current_score = score
	update_score(score)

func _on_side_bar_after_slide_into_view() -> void:
	for die_node: DieNode in GameManager.dice_manager_node.get_children():
		for effect: DieEffect in die_node.die.get_die_effects():
			await effect._on_start_battle(die_node)
