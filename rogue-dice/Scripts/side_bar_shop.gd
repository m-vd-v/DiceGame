class_name SidebarShopNode extends SideBar

@export var shop_panel: RoadmapPanelShop

@onready var dice_holder: NodeHolder = %DiceHolder
@onready var figurines_holder: NodeHolder = %FigurinesHolder

func _ready() -> void:
	ready.connect( func(): print("ready!") )
	update_sidebar()
	await sidebar_bg.after_slide_into_view
	await update_shop_dice()
	await update_figurines()

func update_sidebar() -> void:
	sidebar_bg.update_sidebar(shop_panel)

func update_shop_dice() -> void:
	var dice: Array[Die] = DieGenerator.generate_shop_dice()
	for die in dice:
		var buy_button: BuyButton = create_buy_button(dice_holder)
		var die_node: DieNode = NodeCreator.create_die_node(die, buy_button)
		buy_button.die_node = die_node
		die_node.lock_on_ready = true
		await get_tree().process_frame
		die_node.position = Vector2(buy_button.size.x/2, -48)
		dice_holder.move_nodes()
		await get_tree().create_timer(0.2).timeout

func update_figurines() -> void:
	var figurines: Array[Figurine] = (
		FigurineGenerator.generate_shop_figurines())
	for fig: Figurine in figurines:
		var buy_button: BuyButton = create_buy_button(figurines_holder)
		var fig_node: FigurineNode = NodeCreator.create_figurine_node(
			fig, buy_button)
		buy_button.figurine_node = fig_node
		await get_tree().process_frame
		fig_node.disable_buttons()
		fig_node.position = Vector2(-buy_button.size.x/2, 32)
		figurines_holder.move_nodes()
		await get_tree().create_timer(0.2).timeout

func create_buy_button(parent: NodeHolder) -> BuyButton:
	var buy_button: BuyButton = BuyButton.new()
	buy_button.position.x = 5000
	parent.add_child(buy_button)
	return buy_button






	
