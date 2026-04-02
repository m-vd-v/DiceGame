class_name DieModifierShiny extends DieModifier

func get_title() -> String:
	return "Shiny"
func get_description() -> String:
	return "Whenever you gain money, this die gains that much Temporary Bonus."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Shiny.png")

func _on_added_to_die_node() -> void:
	GameManager.money_updated.connect(_on_gain_money)

func _on_gain_money(amt: int) -> void:
	if amt <= 0 :
		return
	die_node.add_temp_bonus(amt)
