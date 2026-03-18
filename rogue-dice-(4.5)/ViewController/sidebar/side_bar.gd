class_name SideBar extends Node2D

const HEIGHT: int = 1080

func _ready() -> void:
	position.y = HEIGHT
	slide_into_view()

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
