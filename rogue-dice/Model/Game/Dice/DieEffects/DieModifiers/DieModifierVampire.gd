class_name DieModifierVampire extends DieModifier

func get_title() -> String:
	return "Vampire"
func get_description() -> String:
	return ("At the start of a battle, reduce a random side by 1, " +
		"increase a side by 1, and increase a side by 2.")
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Vampire.png")

func _on_start_battle(die_node: DieNode) -> void:
	var die: Die = die_node.die
	var face_indexes: Array = range(int(die.size))
	var reduce_idx: int = face_indexes.pick_random()
	face_indexes.erase(reduce_idx)
	var increase1_idx: int = face_indexes.pick_random()
	face_indexes.erase(increase1_idx)
	var increase2_idx: int = face_indexes.pick_random()
	face_indexes.erase(increase2_idx)
	die.faces[reduce_idx] -= 1
	die.faces[increase1_idx] += 1
	die.faces[increase2_idx] += 2
	die_node.update_die_nr()
	die_node.say("Vampire!")
