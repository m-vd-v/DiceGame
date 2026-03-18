class_name SidebarShopNode extends SideBar

@export var shop_panel: RoadmapPanelShop

@export var shop_dice: Node

func _ready() -> void:
	update_sidebar()
	update_shop_dice()

func update_sidebar() -> void:
	sidebar_bg.update_sidebar(shop_panel)

func update_shop_dice() -> void:
	var dice: Array[Die] = DieGenerator.generate_shop_dice()
	for i in dice.size():
		var die: Die = dice[i]
		var die_node: DieNode = NodeCreator.create_die_node(die)
		shop_dice.add_child(die_node)
		die_node.position.x = i * 150
		die_node.lock()
		var dbb: DieBuyButton = create_die_buy_button()
		shop_dice.add_child(dbb)
		dbb.position = die_node.position + Vector2(
			-(dbb.get_minimum_size().x/2), 50
		)
		dbb.die_node = die_node

func create_die_buy_button() -> DieBuyButton:
	var dbb_pck: PackedScene = load(
		"res://ViewController/RoadMap/sidebar/shop/die_buy_button.tscn"
	)
	var dbb: DieBuyButton = dbb_pck.instantiate()
	return dbb
