class_name SidebarTypeChanger extends SideBar

var die_type: DieType

@export var dice_holder: DiceHolder
@export var buy_button: BuyButton

func _ready() -> void:
	randomize_type()

func randomize_type(exclude_die_types: Array[DieType] = []) -> void:
	die_type = DieGenerator.generate_die_type(
		[DieGenerator.Rarity.COMMON,
		DieGenerator.Rarity.UNCOMMON,
		DieGenerator.Rarity.RARE,],
		exclude_die_types
	)

func commit_sale() -> void:
	var die_node: DieNode = dice_holder.current_die
	GameManager.money -= buy_button.price
	die_node.die.type = die_type
	die_node.update_die_type()
	buy_button.price += 3
	buy_button.update_text()
	randomize_type([die_node.die.type])
	

func _on_buy_button_bought(buy_button: BuyButton) -> void:
	var die_node: DieNode = dice_holder.current_die
	if die_node == null:
		return
	commit_sale()
		
func _on_dice_holder_die_added(dice_holder: DiceHolder) -> void:
	randomize_type([dice_holder.current_die.die.type])
