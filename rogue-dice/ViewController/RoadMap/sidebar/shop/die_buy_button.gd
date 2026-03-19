class_name DieBuyButton extends Button

var die_node: DieNode :
	set(new_die_node):
		die_node = new_die_node
		text = "Buy Die (" + str(die_node.die.price) + ")"

func _on_pressed() -> void:
	if GameManager.money < die_node.die.price:
		die_node.say("Too Expensive!")
		return
	if GameManager.dice_amt >= GameManager.max_dice_amt:
		die_node.say("Too many dice!")
		return
	GameManager.money -= die_node.die.price
	die_node.unlock()
	await GameManager.dice_manager_node.add_die(die_node)
	queue_free()
