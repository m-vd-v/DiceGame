class_name DieBuyButton extends Button

var die_node: DieNode :
	set(new_die_node):
		die_node = new_die_node
		text = "Buy Die (" + str(die_node.die.price) + ")"

func _on_pressed() -> void:
	if GameManager.money < die_node.die.price:
		die_node.say("Too Expensive!")
		return
	GameManager.money -= die_node.die.price
	die_node.unlock()
	var gp: Vector2 = die_node.global_position
	#print(gp, die_node.get_parent().global_position)
	die_node.get_parent().remove_child(die_node)
	GameManager.dice_manager_node.add_child(die_node)
	die_node.global_position = gp
	#print(gp, die_node.global_position)
	var tween: Tween = create_tween()
	tween.tween_property(
		die_node, "position", Vector2.ZERO, 0.5
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	queue_free()
