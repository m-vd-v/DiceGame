extends Node

signal on_reroll

signal lives_updated
var lives: int = 3 :
	set(new_value):
		var add_amt: int = new_value - lives
		lives = new_value
		lives_updated.emit(add_amt)

signal money_updated(add_amt: int)
var money: int = 5 :
	set(new_value):
		var add_amt: int = new_value - money
		money = new_value
		money_updated.emit(add_amt)

signal reroll_amt_updated
var reroll_amt: int = 3 :
	set(new):
		var add_amt: int = new - reroll_amt
		reroll_amt = new
		reroll_amt_updated.emit(add_amt)
var max_rerolls: int = 3 :
	set(new):
		var add_amt: int = new - max_rerolls
		max_rerolls = new
		reroll_amt_updated.emit(add_amt)

signal dice_weight_updated
var dice_weight: int = 8 :
	set(new):
		var add_amt: int = new - dice_weight
		dice_weight = new
		dice_weight_updated.emit(add_amt)
var max_dice_weight: int = 20 :
	set(new):
		var add_amt: int = new - max_dice_weight
		max_dice_weight = new
		dice_weight_updated.emit(add_amt)
func recalculate_dice_weight() -> void:
	dice_manager_node.recalculate_die_weight()

var road_map_node: RoadmapNode
var dice_manager_node: DiceManager

var shop_dice_amt: int = 4
var common_dice_rate: int = 7
var uncommon_dice_rate: int = 3
var rare_dice_rate: int = 1
