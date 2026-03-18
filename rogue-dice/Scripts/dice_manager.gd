class_name DiceManager extends Node2D

func _ready() -> void:
	GameManager.dice_manager_node = self

func roll_all() -> void:
	for d in get_children():
		var die: DieNode = d
		die.roll()
		
