class_name RoadmapLayer extends Resource

enum Type {
	NONE,
	BATTLE,
	SHOP,
	EVENT
}

var type: Type = Type.NONE

@export var panels: Array[RoadmapPanel]

func get_as_string() -> String:
	var text: String = ""
	for panel_idx in panels.size():
		var panel: RoadmapPanel = panels[panel_idx]
		text += panel.get_title()
		if panel_idx != panels.size() - 1:
			text += ", "
	return text

func generate_as_battle_layer(battle: Battle) -> RoadmapLayer:
	var battle_panel: RoadmapPanelBattle = RoadmapPanelBattle.new()
	battle_panel.battle = battle
	panels = [battle_panel]
	return self

var shop_panels: Array[RoadmapPanel] = [
	RoadmapPanelDieSell.new(),
	RoadmapPanelDieUpgrade.new(),
	RoadmapPanelModifier.new(),
	RoadmapPanelTypeChanger.new(),
	RoadmapPanelModifierManager.new()
]

func generate_as_shop_layer(panel_amt: int) -> RoadmapLayer:
	panels.append(RoadmapPanelShop.new())
	for i in panel_amt-1:
		panels.append(
			shop_panels.pick_random()
		)
	return self
