class_name SidebarModifier extends SideBar

var random_modifier: DieModifier

@export var dice_holder: DiceHolder
@export var buy_button: BuyButton
@export var icon: TextureRect
@export var title_label: Label
@export var descr_label: Label

func _ready() -> void:
	randomize_modifier()

func randomize_modifier() -> void:
	random_modifier = DieGenerator.generate_modifier(
		[DieGenerator.Rarity.COMMON,
		DieGenerator.Rarity.UNCOMMON,
		DieGenerator.Rarity.RARE,]
	)
	icon.texture = random_modifier.get_icon()
	title_label.text = random_modifier.get_title()
	descr_label.text = random_modifier.get_description()

func commit_sale() -> void:
	GameManager.money -= buy_button.price
	dice_holder.current_die.update_modifier_sprites()
	buy_button.price += 4
	buy_button.update_text()
	randomize_modifier()
	

func _on_buy_button_bought(buy_button: BuyButton) -> void:
	var die_node: DieNode = dice_holder.current_die
	if die_node == null:
		return
	if die_node.die.modifier1 is DieModifierNone:
		die_node.die.modifier1 = random_modifier
		commit_sale()
	elif die_node.die.modifier2 is DieModifierNone:
		die_node.die.modifier2 = random_modifier
		commit_sale()
	else:
		buy_button.sayer.say("Die already has 2 modifiers!")
		
