class_name RoadmapPanelDieUpgrade extends RoadmapPanel

func get_title() -> String:
	return "Upgrade Dice"

func get_color() -> Color:
	return Color.AQUAMARINE

func get_side_bar_pck() -> PackedScene:
	return load(
		"res://ViewController/RoadMap/sidebar/side_bar_die_upgrade.tscn"
	)
