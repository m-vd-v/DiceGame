class_name RoadmapLayer extends Resource

@export var panels: Array[RoadmapPanel]

func generate_as_battle_layer(battle: Battle) -> RoadmapLayer:
	var battle_panel: RoadmapPanelBattle = RoadmapPanelBattle.new()
	battle_panel.battle = battle
	panels = [battle_panel]
	return self

var rest_panels: Array[RoadmapPanel] = [
	RoadmapPanelShop.new(),
	RoadmapPanelDieSell.new(),
	RoadmapPanelDieUpgrade.new(),
	RoadmapPanelModifier.new(),
	RoadmapPanelTypeChanger.new(),
	RoadmapPanelModifierManager.new()
]

func generate_as_rest_layer(panel_amt: int) -> RoadmapLayer:
	for i in panel_amt:
		panels.append(
			rest_panels.pick_random()
		)
	return self
