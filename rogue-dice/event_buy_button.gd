class_name EventBuyButton extends Control

@onready var buy_button: Button = %BuyButton
@onready var reward_holder: NodeHolder = %RewardHolder
@onready var cost_label: Label = %CostLabel
@onready var sayer: Sayer = %Sayer

@export var check_die_weights: bool = true

@export var queue_free_on_success: bool = true
@export var price: int = 0
@export var die_rewards: Array[Die]
@export var figurine_rewards: Array[Figurine]

func _ready() -> void:
	update_price()
	create_die_nodes()
	create_figurine_nodes()
	reward_holder.move_nodes()

func press_success() -> void:
	for node in reward_holder.get_children():
		if node is DieNode:
			await GameManager.dice_manager_node.add_die(node)
		if node is FigurineNode:
			await GameManager.figurine_manager.add_figurine_node(node)
	queue_free()

func can_use() -> bool:
	if price >= 0:
		if GameManager.try_buy(price) == false:
			sayer.say("Too Expensive!")
			return false
	GameManager.recalculate_dice_weight()
	if (
		(GameManager.dice_weight + get_reward_die_weights()) >
		GameManager.max_dice_weight
	):
		sayer.say("Dice too heavy!")
		return false
	return true

func get_reward_die_weights() -> int:
	var weight: int = 0
	for die in die_rewards:
		weight += die.get_die_weight()
	return weight

func update_price() -> void:
	cost_label.text = "$" + str(price)

func create_die_nodes() -> void:
	for die in die_rewards:
		NodeCreator.create_die_node(die, reward_holder).lock()

func create_figurine_nodes() -> void:
	for fig in figurine_rewards:
		NodeCreator.create_figurine_node(fig, reward_holder)


func _on_buy_button_pressed() -> void:
	if can_use():
		press_success()
