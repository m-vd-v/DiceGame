class_name SideBarBG extends Node2D

signal next_sidebar

const HEIGHT: int = 1080

@export var show_next_buttons_on_ready: bool = true

@export var next_buttons: HBoxContainer

func _ready() -> void:
	if show_next_buttons_on_ready:
		show_next_buttons()
	else:
		hide_next_buttons()
	position.y = HEIGHT
	slide_into_view()

func show_next_buttons() -> void:
	next_buttons.visible = true
func hide_next_buttons() -> void:
	next_buttons.visible = false

func update_sidebar(panel: RoadmapPanel) -> void:
	$TextureRect.self_modulate = panel.get_color()
	$TextureRect/Title.text = panel.get_title()

func update_next_buttons(layer: RoadmapLayer) -> void:
	for panel in layer.panels:
		var button: NextPanelButton = NextPanelButton.new()
		button.panel = panel
		next_buttons.add_child(button)
		button.update()

func slide_into_view() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(
		self, "position", Vector2(0, 0), 0.5
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished

func slide_away() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(
		self, "position", Vector2(0, -HEIGHT), 0.5
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
