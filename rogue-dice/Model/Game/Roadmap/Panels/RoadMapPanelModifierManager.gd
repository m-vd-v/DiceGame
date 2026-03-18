class_name RoadmapPanelModifierManager extends RoadmapPanel

func get_title() -> String:
	return "Manage Modifiers"

func get_color() -> Color:
	return Color.DARK_OLIVE_GREEN

func get_side_bar_pck() -> PackedScene:
	return load(
		"res://ViewController/RoadMap/sidebar/side_bar_modifier_manager.tscn"
	)
