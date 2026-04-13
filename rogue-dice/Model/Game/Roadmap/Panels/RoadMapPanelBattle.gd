class_name RoadmapPanelBattle extends RoadmapPanel

@export var battle: Battle

func get_title() -> String:	
	return "Battle: " + battle.boss.get_title()

func get_color() -> Color:
	return Color(0.75, 0.255, 0.255, 1.0)

func get_side_bar_pck() -> PackedScene:
	return load(
		"res://ViewController/RoadMap/sidebar/side_bar_battle.tscn"
	)
