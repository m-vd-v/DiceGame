class_name FigurineHealerKit extends Figurine

func get_title() -> String:
	return "Healer Kit"
func get_description() -> String:
	return (
		"Start of battle: If you have less than 3 lives, gain 1 live."
	)
func get_texture() -> Texture:
	return load(
		"res://Assets/Images/Sprites/DieModifiers/Heal.png"
	)

func _on_battle_start() -> void:
	if GameManager.lives < 3:
		GameManager.lives += 1
		updated.emit("+1 Life!")
