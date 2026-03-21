class_name DieCurseGlass extends DieCurse

func get_title() -> String:
	return "Glass"
func get_description() -> String:
	return ("At the start of a battle, increase all faces by 1. Afterwards, " + 
	"there is a face value % chance for the die to be destroyed.")
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/DieCurses/Glass.png")

func _on_start_battle() -> void:
	for i in die_node.die.size:
		die_node.die.faces[i] += 1
	die_node.update_die_nr()
	if randi_range(0, 100) < die_node.die.current_face:
		die_node.say("Broken!")
		await die_node.destroy()
	else:
		die_node.say("Unbroken!")
