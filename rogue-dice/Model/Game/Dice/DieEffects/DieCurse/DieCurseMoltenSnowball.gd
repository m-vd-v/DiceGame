class_name DieCurseMoltenSnowball extends DieCurse

func get_title() -> String:
	return "Melting Snowball"
func get_description() -> String:
	return ("At the start of a battle, this die gains +5 Temporary Bonus. " +
	"When this die is rolled, it loses 3 Temporary Bonus.")
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DieCurses/MoltenSnowball.png")
