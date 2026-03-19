extends Node2D

@export var dice_mngr: DiceManager
@export var roll_button: Button
@export var money_label: Label
@export var lives_label: Label
@export var dice_amt_label: Label

func _ready() -> void:
	update_visuals()
	GameManager.lives_updated.connect(update_visuals)
	GameManager.money_updated.connect(update_visuals)
	GameManager.reroll_amt_updated.connect(update_visuals)
	GameManager.dice_amt_updated.connect(update_visuals)

func update_visuals() -> void:
	roll_button.text = (
		"Roll Dice (" + str(GameManager.reroll_amt) +
		"/" + str(GameManager.max_rerolls) + ")"
	)
	money_label.text = (
		"Money: " + str(GameManager.money)
	)
	lives_label.text = (
		"Lives: " + str(GameManager.lives)
	)
	dice_amt_label.text = (
		"Amount of Dice: " + str(GameManager.dice_amt) + " / " +
		str(GameManager.max_dice_amt)
	)
	
func _on_roll_button_pressed() -> void:
	if GameManager.reroll_amt <= 0:
		return
	GameManager.on_reroll.emit()
	dice_mngr.roll_all()
	GameManager.reroll_amt -= 1
