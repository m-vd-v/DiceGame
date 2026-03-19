extends Node

signal on_reroll

signal lives_updated
var lives: int = 3 :
	set(new_value):
		lives = new_value
		lives_updated.emit()

signal money_updated
var money: int = 5 :
	set(new_value):
		money = new_value
		money_updated.emit()

signal reroll_amt_updated
var reroll_amt: int = 3 :
	set(new):
		reroll_amt = new
		reroll_amt_updated.emit()
var max_rerolls: int = 3 :
	set(new):
		max_rerolls = new
		reroll_amt_updated.emit()

signal dice_amt_updated
var dice_amt: int = 8 :
	set(new):
		dice_amt = new
		dice_amt_updated.emit()
var max_dice_amt: int = 10 :
	set(new):
		max_dice_amt = new
		dice_amt_updated.emit()
func recalculate_dice_amt() -> void:
	dice_manager_node.recalculate_die_amt()

var road_map_node: RoadmapNode
var dice_manager_node: DiceManager

var shop_dice_amt: int = 4
var common_dice_rate: int = 7
var uncommon_dice_rate: int = 3
var rare_dice_rate: int = 1
