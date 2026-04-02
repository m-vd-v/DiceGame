class_name Sayer extends Node2D

@export var speed: float = 1
@export var start_pos: Vector2
@export var end_pos: Vector2

@export var label_settings: LabelSettings

func say(text: String) -> void:
	var label: Label = Label.new()
	add_child(label)
	label.text = text
	label.position = start_pos
	label.modulate = Color.TRANSPARENT
	label.label_settings = label_settings
	label.set_anchors_preset(Control.PRESET_CENTER)
	
	var move_tween: Tween = create_tween()
	move_tween.tween_property(
		label, "position", end_pos, 2.0 * speed
	)
	
	var fade_in_tween: Tween = create_tween()
	fade_in_tween.tween_property(
		label, "modulate", Color.WHITE, 0.25 * speed
	)
	await fade_in_tween.finished
	
	await get_tree().create_timer(1.5).timeout
	
	var fade_out_tween: Tween = create_tween()
	fade_out_tween.tween_property(
		label, "modulate", Color.TRANSPARENT, 0.25 * speed
	)
	await fade_out_tween.finished
	
	label.queue_free()
