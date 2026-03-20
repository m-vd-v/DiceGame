class_name DieInfo extends Control

@export var margin_container: MarginContainer

@export var bg: ColorRect
@export var text_container: VBoxContainer

@export var size_label: Label
@export var bonus_label: Label
@export var type_label: Label
@export var type_descr: Label
@export var mod_1_title_label: Label
@export var mod_1_descr_label: Label
@export var mod_2_title_label: Label
@export var mod_2_descr_label: Label
@export var die_value_shower: DieValuesShower
@export var curse_title_label: Label
@export var curse_descr_label: Label

@onready var weight_label: Label = %WeightLabel

func show_info(die: Die) -> void:
	update(die)
	show()
	margin_container.modulate = Color.TRANSPARENT
	await get_tree().process_frame
	set_screen_position()
	create_tween().tween_property(
		margin_container, "modulate", Color.WHITE, 0.2
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

func hide_info() -> void:
	await create_tween().tween_property(
		margin_container, "modulate", Color.TRANSPARENT, 0.2
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).finished
	hide()

func update(die: Die) -> void:		
	size_label.text = "d" + str(die.size)
	bonus_label.text = (
		die.get_bonus_in_string( die.permanent_bonus, true ) + " (permanent) / " +
		die.get_bonus_in_string( die.temporary_bonus, true ) + " (temporary)"
	)
	type_label.text = die.type.get_title()
	type_descr.text = die.type.get_description()
	die_value_shower.update(die)
	mod_1_title_label.text = die.modifier1.get_title()
	mod_1_descr_label.text = die.modifier1.get_description()
	mod_2_title_label.text = die.modifier2.get_title()
	mod_2_descr_label.text = die.modifier2.get_description()
	curse_title_label.text = die.curse.get_title()
	curse_descr_label.text = die.curse.get_description()
	weight_label.text = str(die.get_die_weight())

func set_screen_position() -> void:
	var g_pos: Vector2 = global_position
	var c_transform: Transform2D = get_canvas_transform()
	var max_border: Vector2 = c_transform.get_origin() + get_viewport_rect().size
	var overshoot: Vector2 = (margin_container.size + g_pos) - max_border
	var aim_pos: Vector2 = Vector2()
	aim_pos.x = -max(0, overshoot.x)
	aim_pos.y = -max(0, overshoot.y)
	$Control.position = aim_pos
	
	
