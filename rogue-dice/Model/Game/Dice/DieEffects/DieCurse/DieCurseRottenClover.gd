class_name DieCurseRottenClover extends DieCurse

func get_title() -> String:
	return "Rotten Clover"
func get_description() -> String:
	return ("At the start of a battle, you lose 1 reroll.
		After battle, gain 2 rerolls.")
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DieCurses/RottenClover.png")

func _on_start_battle() -> void:
	GameManager.reroll_amt -= 1

func _after_battle() -> void:
	GameManager.reroll_amt += 2
