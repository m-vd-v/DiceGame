class_name Roadmap extends Resource

@export var layers: Array[RoadmapLayer]

func fill_roadmap() -> void:
	var start_score: int = 50
	for i in 50:
		var battle: Battle = Battle.new()
		battle.score = start_score
		start_score += 25 * int(start_score/50)
		layers.append(
			RoadmapLayer.new().generate_as_battle_layer(battle)
		)
		layers.append(
			RoadmapLayer.new().generate_as_rest_layer(2)
		)
		layers.append(
			RoadmapLayer.new().generate_as_rest_layer(3)
		)
