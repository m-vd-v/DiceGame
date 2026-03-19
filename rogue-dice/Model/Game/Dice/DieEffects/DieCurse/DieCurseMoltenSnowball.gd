class_name DieCurseMoltenSnowball extends DieCurse

func get_title() -> String:
	return "Molten Snowball"
func get_description() -> String:
	return ("At the start of a battle, this die gains +5 Temporary Bonus. " +
	"When this die is rolled, it loses 3 Temporary Bonus.")
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DieCurses/MoltenSnowball.png")

func _on_start_battle(die_node: DieNode) -> void:
	die_node.add_temp_bonus(5)

func _replace_roll(die_node: DieNode) -> void: pass

func _after_reroll(die_node: DieNode) -> void:
	die_node.add_temp_bonus(-3)

func _after_score(_die_node: DieNode,
			_dice_scored_before: Array[DieNode], _dice_scored_after: Array[DieNode]
		) -> void:
	pass

func _on_gain_temp_bonus(_die_node: DieNode, _gain_amt: int) -> void:
	pass

func _on_gain_perm_bonus(_die_node: DieNode, _gain_amt: int) -> void:
	pass

func _after_scoring_done(_die_node: DieNode, 
			_all_die_nodes_scored: Array[DieNode]
		) -> void:
	pass
