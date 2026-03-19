class_name SidebarModifierManager extends SideBar

var random_modifier: DieModifier

@export var dice_holder: DiceHolder

@export var remove_left_mod: BuyButton
@export var remove_right_mod: BuyButton
@export var swap_mods: BuyButton

func _on_remove_left_modifier_bought(buy_button: BuyButton) -> void:
	var die_node: DieNode = dice_holder.current_die
	if die_node == null:
		return
	if die_node.die.modifier1 is DieModifierNone:
		return
	die_node.die.modifier1 = DieModifierNone.new()
	GameManager.money -= remove_left_mod.price
	die_node.update_modifier_sprites()

func _on_remove_right_modifier_bought(buy_button: BuyButton) -> void:
	var die_node: DieNode = dice_holder.current_die
	if die_node == null:
		return
	if die_node.die.modifier2 is DieModifierNone:
		return
	die_node.die.modifier2 = DieModifierNone.new()
	GameManager.money -= remove_right_mod.price
	die_node.update_modifier_sprites()

func _on_swap_modifiers_bought(buy_button: BuyButton) -> void:
	var die_node: DieNode = dice_holder.current_die
	if die_node == null:
		return
	if ((die_node.die.modifier1 is DieModifierNone) and 
			(die_node.die.modifier2 is DieModifierNone)):
		return
	var mod1: DieModifier = die_node.die.modifier1.duplicate()
	die_node.die.modifier1 = die_node.die.modifier2
	die_node.die.modifier2 = mod1
	die_node.update_modifier_sprites()
