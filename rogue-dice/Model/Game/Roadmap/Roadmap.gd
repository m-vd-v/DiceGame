class_name Roadmap extends Resource

@export var layers: Array[RoadmapLayer]

func fill_roadmap() -> void:
	var req_score: int = 50
	add_standard_battle(req_score)
	for i in 50:
		req_score = increase_req_score(req_score)
		create_ante(req_score)
		req_score = increase_req_score(req_score)
		create_ante(req_score, true)

func increase_req_score(req_score: int) -> int:
	return req_score + (25 * int(float(req_score)/50))

func add_standard_battle(req_score: int) -> void:
	var battle: Battle = Battle.new()
	battle.req_score = req_score
	layers.append(
		RoadmapLayer.new().generate_as_battle_layer(battle)
	)

func add_boss_battle(req_score: int) -> void:
	var boss_battle: Battle = Battle.new()
	boss_battle.req_score = req_score
	boss_battle.boss = BossGenerator.generate_boss()
	layers.append(
		RoadmapLayer.new().generate_as_battle_layer(boss_battle)
	)

func create_ante(req_score: int, is_boss: bool = false) -> void:
		layers.append(
			RoadmapLayer.new().generate_as_shop_layer(2)
		)
		layers.append(
			RoadmapLayer.new().generate_as_shop_layer(3)
		)
		if is_boss:
			add_boss_battle(req_score)
		else:
			add_standard_battle(req_score)
