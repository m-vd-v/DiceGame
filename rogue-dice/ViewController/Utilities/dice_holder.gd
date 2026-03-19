class_name DiceHolder extends Node2D

signal swap_button_pressed(dice_holder: DiceHolder)

signal die_added(dice_holder: DiceHolder)

@export var do_dice_lock: bool = false
@export var lock_dice_on_reroll: bool = true

@export var swap_button: Button
@export var dice_detector: Area2D

var current_die: DieNode = null

func _ready() -> void:
	GameManager.on_reroll.connect(_on_reroll)

func move_die_here(die: DieNode = current_die) -> void:
	var rot_tween: Tween = create_tween()
	rot_tween.tween_property(
		die, "global_rotation", 0.0, 0.2
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	var move_tween: Tween = create_tween()
	move_tween.tween_property(
		die, "global_position", self.global_position, 0.2
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	await move_tween.finished

func add_die(new_die: DieNode) -> void:
	current_die = new_die
	current_die.grab_area.start_grab.connect(_die_pick_up)
	current_die.freeze = true
	if do_dice_lock:
		current_die.lock()
	move_die_here()
	die_added.emit(self)

func remove_die(die: DieNode = current_die, remove_lock: bool = true) -> void:
	if die == null:
		return
	dice_detector.monitoring = true
	var area: DieGrabArea = die.grab_area
	if area.start_grab.is_connected(_die_pick_up):
		area.start_grab.disconnect(_die_pick_up)
	die.freeze = false
	if remove_lock:
		die.unlock()
	current_die = null

func kick_die(die: DieNode = current_die) -> void:
	if die == null:
		return
	var tween: Tween = create_tween()
	tween.tween_property(
		die, "position",
		die.position - Vector2(200, 0), 0.5
	).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	remove_die(die)
	die.roll(Vector2(-1, 0))

func set_new_die(new_die: DieNode) -> void:
	dice_detector.monitoring = false
	if current_die != null and current_die != new_die:
		kick_die(current_die)
	add_die(new_die)

func _die_pick_up(area: DieGrabArea) -> void:
	remove_die(area.die_node)

func _die_let_go(area: DieGrabArea) -> void:
	var die: DieNode = area.die_node
	set_new_die(die)

func _on_dice_detector_area_entered(area: Area2D) -> void:
	if area is DieGrabArea:
		area.end_grab.connect(_die_let_go)

func _on_dice_detector_area_exited(area: Area2D) -> void:
	if area is DieGrabArea:
		area.end_grab.disconnect(_die_let_go)

func _on_swap_button_pressed() -> void:
	swap_button_pressed.emit(self)

func _on_reroll() -> void:
	if lock_dice_on_reroll and current_die != null:
		current_die.lock()
