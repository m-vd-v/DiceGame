class_name DieModifierCoin extends DieModifier

func get_title() -> String:
	return "Coin"
func get_description() -> String:
	return "After scoring, you gain money equal to the dice's face value (no bonus)."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Coin.png")

## override
func _after_scoring_done(die_node: DieNode, 
			_all_die_nodes_scored: Array[DieNode]
		) -> void:
	GameManager.money += die_node.die.get_current_face_value()
	await die_node.do_highlight_animation()
