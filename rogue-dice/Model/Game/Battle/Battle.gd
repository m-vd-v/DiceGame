class_name Battle extends Resource

@export var score: int = 20

var current_score: int

func start() -> void:
	current_score = 0

func has_won() -> bool:
	return current_score >= score
