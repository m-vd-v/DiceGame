class_name GrabArea extends Area2D

signal start_grab(grab_area: GrabArea)
signal end_grab(grab_area: GrabArea)

@export var drag_object: Node
@export var do_physics_based_grab: bool = false
@export var force_multiplier: int = 10

var active: bool = true

var dragging: bool = false :
	set(new_value):
		dragging = new_value
		if new_value == true:
			start_grab.emit(self)
		else:
			end_grab.emit(self)

func _ready() -> void:
	input_event.connect(_on_input_event)

func _process(_delta: float) -> void:		
	if dragging:
		if Input.is_action_just_released("mouseL"):
			dragging = false
		if do_physics_based_grab:
			physics_drag()
			return
		drag_object.global_position = get_global_mouse_position()

func physics_drag() -> void:
	if drag_object is RigidBody2D:
		var dir: Vector2 = (
				get_global_mouse_position() - drag_object.global_position
			)
		const MAX_SPEED: int = 400
		if dir.length() > MAX_SPEED:
			dir /= dir.length() / MAX_SPEED
		#dir = Vector2(min(dir.x, 100), min(dir.y, 100))
		drag_object.linear_velocity = dir * force_multiplier

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("mouseL") and active:
		dragging = true
