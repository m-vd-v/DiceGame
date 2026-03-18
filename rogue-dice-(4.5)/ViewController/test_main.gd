extends Node2D

@export var battle: Battle

@export var dice_mngr: DiceManager
@export var dice_holder_holder: DiceHolderHolder
@export var roll_button: Button
@export var score_label: Label

func _ready() -> void:
	start_battle()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var new_battle: Battle = Battle.new()
		new_battle.score = battle.score * 1.5
		battle = new_battle
		start_battle()

func start_battle() -> void:
	battle.start()
	update_visuals()

func update_visuals() -> void:
	roll_button.text = (
		"Roll " + str(battle.rolls_left) + "/" +
		str(GameManager.reroll_amt)
	)
	score_label.text = (
		"Score: " + str(battle.current_score) +
		"/" + str(battle.score)
	)

func _on_roll_button_pressed() -> void:
	if battle.rolls_left <= 0:
		return
	dice_mngr.roll_all()
	battle.rolls_left -= 1
	update_visuals()


func _on_dice_holder_holder_updated_score(score: int) -> void:
	battle.current_score = score
	update_visuals()


func _on_score_button_pressed() -> void:
	dice_holder_holder.count_score()
