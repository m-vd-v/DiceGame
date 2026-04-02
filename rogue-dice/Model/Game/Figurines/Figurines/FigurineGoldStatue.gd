class_name FigurineGoldStatue extends Figurine

func get_title() -> String:
	return "Gold Statue"
func get_description() -> String:
	return (
		"Gains +2 value after each battle. Click button to collect money."
	)
func get_texture() -> Texture:
	return load(
		"res://Assets/Images/Sprites/Figurines/GoldStatue.png"
	)

func should_show_value() -> bool: return true

func _on_battle_end() -> void:
	value += 2
	updated.emit("+2 Money!")

func create_buttons() -> Array[SnackButton]:
	return [
		SnackButton.create_button("Collect Money", collect_money)
	]

func collect_money() -> void:
	GameManager.money += value
	value = 0
	updated.emit()
