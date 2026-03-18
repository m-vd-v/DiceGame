class_name NextPanelButton extends Button

var panel: RoadmapPanel 

func _ready() -> void:
	self.custom_minimum_size.x = 200
	pressed.connect(_on_pressed)

func update() -> void:
	text = panel.get_title()

func _on_pressed() -> void:
	GameManager.road_map_node.next_sidebar(panel)
