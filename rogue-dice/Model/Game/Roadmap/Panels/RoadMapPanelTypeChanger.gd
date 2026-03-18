class_name RoadmapPanelTypeChanger extends RoadmapPanel

func get_title() -> String:
	return "Change the Type of a die"

func get_color() -> Color:
	return Color.DARK_GOLDENROD

func get_side_bar_pck() -> PackedScene:
	return load(
		"res://ViewController/RoadMap/sidebar/side_bar_type_changer.tscn"
	)
