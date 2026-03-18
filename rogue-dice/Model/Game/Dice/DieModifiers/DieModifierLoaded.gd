class_name DieModifierLoaded extends DieModifier

func get_title() -> String:
	return "Loaded"
func get_description() -> String:
	return "Has a 50% chance to roll its maximum value."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Loaded.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _after_reroll(die_node: DieNode) -> void:
	if randi_range(0, 100) < 50:
		return
	var die: Die = die_node.die
	var highest_face: int = die.get_faces().max()
	var highest_face_idx: int = die.faces.find(highest_face)
	die.current_face = highest_face_idx
	die_node.update_die_nr()

func _after_score(die_node: DieNode,
			dice_scored_before: Array[DieNode], dice_scored_after: Array[DieNode]
		) -> void:
	pass

func _on_gain_temp_bonus(die_node: DieNode, gain_amt: int) -> void:
	pass

func _on_gain_perm_bonus(die_node: DieNode, gain_amt: int) -> void:
	pass

func _after_scoring_done(die_node: DieNode, 
			all_die_nodes_scored: Array[DieNode]
		) -> void:
	pass
