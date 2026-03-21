class_name DieModifierHeal extends DieModifier

var delete_on_next_roll: bool = false

func get_title() -> String:
	return "Heal"
func get_description() -> String:
	return "After scoring, gives +1 Live and destroys die after next roll."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Heal.png")

func _after_reroll() -> void:
	if delete_on_next_roll:
		die_node.queue_free()

func _after_scoring_done(all_die_nodes_scored: Array[DieNode]) -> void:
	GameManager.lives += 1
	delete_on_next_roll = true
