class_name DieCurseCasinoDie extends DieCurse

func get_title() -> String:
	return "CasinoDie"
func get_description() -> String:
	return "Has a 50% chance to roll its smallest value."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DieCurses/CasinoDie.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _replace_roll(die_node: DieNode) -> void:
	if randi_range(0, 100) < 50:
		return
	var die: Die = die_node.die
	var highest_face: int = die.get_faces().min()
	var highest_face_idx: int = die.faces.find(highest_face)
	die.current_face = highest_face_idx
	die_node.update_die_nr()

func _after_reroll(_die_node: DieNode) -> void: pass

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
