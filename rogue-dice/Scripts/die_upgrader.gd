extends Node2D

@export var price: int = 5
@export var level: int = 1

@export var upgrade_die_holder: DiceHolder
@export var buy_button: BuyButton

func _ready() -> void:
	buy_button.button_text = "+" + str(level) + " to Die"
	buy_button.price = price
	buy_button.update_text()

func _on_upgrade_buy_button_bought(_buy_button: BuyButton) -> void:
	if upgrade_die_holder.current_die == null:
		return
	upgrade_die_holder.current_die.add_perm_bonus(level)
	GameManager.money -= buy_button.price
	buy_button.queue_free()
