class_name FigurineReroll extends Figurine

func get_title() -> String:
	return "Reroll Figurine"
func get_description() -> String:
	return (
		"Start of battle: Gain 1 reroll."
	)
func get_texture() -> Texture:
	return load(
		"res://Assets/Images/Sprites/Figurines/Reroll.png"
	)

func _on_battle_start() -> void:
	GameManager.reroll_amt += 1
	updated.emit("+1 Reroll!")
