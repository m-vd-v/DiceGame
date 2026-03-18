class_name DieModifierHeal extends DieModifier

var delete_on_next_roll: bool = false

func get_title() -> String:
	return "Heal"
func get_description() -> String:
	return "After scoring, gives +1 Live and destroys die after next roll."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Heal.png")

func _on_start_battle(_die_node: DieNode) -> void: pass

func _after_reroll(die_node: DieNode) -> void:
	if delete_on_next_roll:
		die_node.queue_free()

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
	GameManager.lives += 1
	delete_on_next_roll = true
