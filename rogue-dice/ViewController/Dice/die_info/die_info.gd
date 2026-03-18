class_name DieInfo extends Control

@export var size_label: Label
@export var bonus_label: Label
@export var type_label: Label
@export var type_descr: Label
@export var mod_1_title_label: Label
@export var mod_1_descr_label: Label
@export var mod_2_title_label: Label
@export var mod_2_descr_label: Label
@export var die_value_shower: DieValuesShower

@export var test_die: Die

func _ready() -> void:
	update(test_die)

func update(die: Die) -> void:
	size_label.text = "d" + str(die.size)
	bonus_label.text = (
		die.get_bonus_in_string( die.permanent_bonus, true ) + " (permanent) / " +
		die.get_bonus_in_string( die.temporary_bonus, true ) + " (temporary)"
	)
	type_label.text = die.type.get_title()
	type_descr.text = die.type.get_description()
	die_value_shower.update(die.size, die.faces)
	mod_1_title_label.text = die.modifier1.get_title()
	mod_1_descr_label.text = die.modifier1.get_description()
	mod_2_title_label.text = die.modifier2.get_title()
	mod_2_descr_label.text = die.modifier2.get_description()
