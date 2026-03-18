class_name Battle extends Resource

@export var score: int = 20

var current_score: int
var rolls_left: int

func start() -> void:
	rolls_left = GameManager.reroll_amt
	current_score = 0
