class_name DieCurseMoltenSnowball extends DieCurse

func get_title() -> String:
	return "Melting Snowball"
func get_description() -> String:
	return ("At the start of a battle, this die gains +5 Temporary Bonus. " +
	"When this die is rolled, it loses 3 Temporary Bonus.")
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DieCurses/MoltenSnowball.png")

func _on_start_battle() -> void:
	die_node.add_temp_bonus(5)

func _after_reroll() -> void:
	die_node.add_temp_bonus(-3)
