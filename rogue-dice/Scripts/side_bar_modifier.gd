class_name SidebarModifier extends SideBar

var random_modifier: DieModifier
var random_curse: DieCurse

@export var dice_holder: DiceHolder
@export var buy_button: BuyButton
@export var mod_icon: TextureRect
@export var mod_title_label: Label
@export var mod_descr_label: Label
@export var curse_icon: TextureRect
@export var curse_title_label: Label
@export var curse_descr_label: Label

func _ready() -> void:
	randomize_modifier()

func randomize_modifier() -> void:
	random_modifier = DieGenerator.generate_modifier(
		[DieGenerator.Rarity.COMMON,
		DieGenerator.Rarity.UNCOMMON,
		DieGenerator.Rarity.RARE,]
	)
	if randi_range(0, 100) < 50:
		random_curse = DieGenerator.generate_curse(
			[DieGenerator.Rarity.COMMON,
			DieGenerator.Rarity.UNCOMMON,
			DieGenerator.Rarity.RARE,]
		)
	else:
		random_curse = DieCurseNone.new()
	update_visuals()

func update_visuals() -> void:
	mod_icon.texture = random_modifier.get_icon()
	mod_title_label.text = random_modifier.get_title()
	mod_descr_label.text = random_modifier.get_description()
	curse_icon.texture = random_curse.get_icon()
	curse_title_label.text = random_curse.get_title()
	curse_descr_label.text = random_curse.get_description()

func commit_sale(die_node: DieNode) -> void:
	die_node.die.curse = random_curse
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
		commit_sale(die_node)
	elif die_node.die.modifier2 is DieModifierNone:
		die_node.die.modifier2 = random_modifier
		commit_sale(die_node)
	else:
		buy_button.sayer.say("Die already has 2 modifiers!")
		
