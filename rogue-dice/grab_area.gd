class_name GrabArea extends Area2D

signal start_grab(grab_area: GrabArea)
signal end_grab(grab_area: GrabArea)

signal start_hover
signal end_hover

var hovering: bool = false

@export var drag_object: Node
@export var do_physics_based_grab: bool = false
@export var force_multiplier: int = 10

var active: bool = true

var hover_timer: Timer = Timer.new()
var mouse_in_area: bool = false
var dragging: bool = false :
	set(new_value):
		dragging = new_value
		if new_value == true:
			start_grab.emit(self)
		else:
			end_grab.emit(self)

func _ready() -> void:
	add_child(hover_timer)
	hover_timer.one_shot = true
	hover_timer.wait_time = 0.5
	hover_timer.timeout.connect(_on_hover_timer_timeout)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta: float) -> void:
	if mouse_in_area:
		if not dragging:
			start_hover_timer()
		if Input.is_action_just_pressed("mouseL") and active:
			dragging = true	
	else:
		end_hover_timer()
	if dragging:
		end_hover_timer()
		if Input.is_action_just_released("mouseL"):
			dragging = false
		if do_physics_based_grab:
			physics_drag()
			return
		drag_object.global_position = get_global_mouse_position()

func start_hover_timer() -> void:
	if not hovering and hover_timer.is_stopped():
		hover_timer.start()

func end_hover_timer() -> void:
	if hovering:
		end_hover.emit()
		hovering = false
	if not hover_timer.is_stopped():
		hover_timer.stop()

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


func _on_mouse_entered() -> void:
	mouse_in_area = true
func _on_mouse_exited() -> void:
	mouse_in_area = false


func _on_hover_timer_timeout() -> void:
	start_hover.emit()
	hovering = true
