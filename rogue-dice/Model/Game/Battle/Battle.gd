class_name Battle extends Resource

@export var boss: Boss = BossNone.new()

@export var req_score: int = 20

var current_score: int

func start() -> void:
	current_score = 0
	await boss._on_battle_start()

func end() -> void:
	await boss._on_battle_end()

func has_won() -> bool:
	return current_score >= req_score
