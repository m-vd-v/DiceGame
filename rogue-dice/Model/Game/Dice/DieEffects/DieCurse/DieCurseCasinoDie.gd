class_name DieCurseCasinoDie extends DieCurse

func get_title() -> String:
	return "CasinoDie"
func get_description() -> String:
	return "Has a 50% chance to roll its smallest value."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DieCurses/CasinoDie.png")

func _on_start_battle() -> void: pass

func _replace_roll() -> void:
	if randi_range(0, 100) < 50:
		return
	var die: Die = die_node.die
	var highest_face: int = die.get_faces().min()
	var highest_face_idx: int = die.faces.find(highest_face)
	die.current_face = highest_face_idx
	die_node.update_die_nr()
