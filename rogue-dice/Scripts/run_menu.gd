class_name RunMenu extends Control

var is_active: bool = false

func update() -> void:
	update_ante()

func update_ante() -> void:
	var text: String = ""
	var layers: Array[RoadmapLayer] = GameManager.road_map_node.roadmap.layers
	for layer_idx: int in 6:
		if layer_idx >= layers.size():
			break
		var layer: RoadmapLayer = layers[layer_idx]
		text += layer.get_as_string() + "\n"
	text += "..."
	%AnteList.text = text

func appear() -> void:
	is_active = true
	self.visible = true
	update()

func dissapear() -> void:
	is_active = false
	self.visible = false

func toggle_appear() -> void:
	if is_active:
		dissapear()
		return
	appear()
