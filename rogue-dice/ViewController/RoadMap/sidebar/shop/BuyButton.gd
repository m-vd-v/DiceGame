class_name BuyButton extends Button

signal bought(buy_button: BuyButton)

@export_multiline() var button_text: String = "Buy"
@export var price: int = 5
@export var dont_remove_price_from_money: bool = false
@export var sayer_end_pos: Vector2 = Vector2(0, 100)

@export var queue_free_on_bought: bool = true

var sayer: Sayer = Sayer.new()

@export var die_node: DieNode
@export var figurine_node: FigurineNode

func _ready() -> void:
	add_child(sayer)
	sayer.start_pos = Vector2.ZERO
	sayer.end_pos = sayer_end_pos
	pressed.connect(try_buy)
	update_text()

func update_text() -> void:
	text = button_text + " (" + str(price) + ")"

func try_buy() -> void:
	if GameManager.money < price:
		sayer.say("Too Expensive!")
		return
	if not dont_remove_price_from_money:
		GameManager.money -= price
	bought.emit(self)
	
	if die_node != null:
		GameManager.dice_manager_node.add_die(die_node)
	if figurine_node != null:
		GameManager.figurine_manager.add_figurine_node(figurine_node)
		figurine_node.enable_buttons()
	
	if queue_free_on_bought:
		await get_tree().process_frame
		queue_free()
