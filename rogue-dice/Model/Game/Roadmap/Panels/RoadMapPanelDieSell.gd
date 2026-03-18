class_name RoadmapPanelDieSell extends RoadmapPanel

func get_title() -> String:
	return "Sell Die"

func get_color() -> Color:
	return Color.CORAL

func get_side_bar_pck() -> PackedScene:
	return load(
		"res://ViewController/RoadMap/sidebar/side_bar_die_sell.tscn"
	)
