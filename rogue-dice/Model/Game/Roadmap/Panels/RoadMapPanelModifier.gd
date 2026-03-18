class_name RoadmapPanelModifier extends RoadmapPanel

func get_title() -> String:
	return "Add Modifier"

func get_color() -> Color:
	return Color.CHARTREUSE

func get_side_bar_pck() -> PackedScene:
	return load(
		"res://ViewController/RoadMap/sidebar/side_bar_modifier.tscn"
	)
