class_name RoadmapNode extends Node2D

@export var roadmap: Roadmap = Roadmap.new()

var current_side_bar: SideBar
var current_panel_idx: int = -1

func _ready() -> void:
	roadmap.fill_roadmap()
	GameManager.road_map_node = self
	next_sidebar(roadmap.layers.pop_front().panels[0])

func get_current_panel() -> RoadmapPanel:
	return roadmap.panels[current_panel_idx]

func next_sidebar(panel: RoadmapPanel) -> void:
	var side_bar_pck: PackedScene = panel.get_side_bar_pck()
	var side_bar: SideBar = side_bar_pck.instantiate()
	side_bar.panel = panel
	side_bar.update_sidebar()
	
	side_bar.sidebar_bg.update_next_buttons(
		roadmap.layers.pop_front()
	)
	
	add_child(side_bar)
	var old_side_bar: SideBar = current_side_bar
	current_side_bar = side_bar
	if old_side_bar == null: return
	await old_side_bar.sidebar_bg.slide_away()
	old_side_bar.queue_free()
	
