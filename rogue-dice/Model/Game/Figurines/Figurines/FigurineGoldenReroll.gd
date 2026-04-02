class_name FigurineGoldenReroll extends Figurine

func get_title() -> String:
	return "Golden Reroll"
func get_description() -> String:
	return (
		"Gain +1 money per reroll used."
	)
func get_texture() -> Texture:
	return load(
		"res://Assets/Images/Sprites/Figurines/GoldenReroll.png"
	)

func _on_reroll() -> void:
	GameManager.money += 1
	updated.emit("+1 money for reroll!")
