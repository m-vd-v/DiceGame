class_name SidebarDieSellNode extends SideBar

@export var die_holder: DiceHolder

func _on_destroy_die_button_pressed() -> void:
	if die_holder.current_die == null:
		return
	GameManager.money += 5
	die_holder.current_die.queue_free()
	die_holder.queue_free()
