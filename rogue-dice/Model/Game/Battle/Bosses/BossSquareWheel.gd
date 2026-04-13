class_name BossSquareWheel extends Boss

func get_title() -> String:
	return "Square Wheel"

func get_description() -> String:
	return "-1 Reroll."

func _on_battle_start() -> void:
	GameManager.reroll_amt -= 1
