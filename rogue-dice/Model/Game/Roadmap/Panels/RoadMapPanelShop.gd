class_name RoadmapPanelShop extends RoadmapPanel

func get_title() -> String:
	return "Shop"

func get_color() -> Color:
	return Color.AQUA

func get_side_bar_pck() -> PackedScene:
	return load(
		"res://ViewController/RoadMap/sidebar/shop/side_bar_shop.tscn"
	)
