class_name DieNode extends RigidBody2D

const ROLL_FORCE: int = 150 * 1000
const ROLL_TIME: float = 0.1

@export var grab_area: DieGrabArea

@onready var sprite: Sprite2D = $DieSprite
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var grab_area_collision: CollisionShape2D = $DieGrabArea/GrabCollision
@onready var nr_label: Label = $DieSprite/CenterContainer/NumberLabel

@export var die: Die

var locked: bool = false

var in_dice_tray: bool = false
var grabbed: bool = false

func _ready() -> void:
	update_die_size()
	update_die_nr(die.roll())
	modulate = Color(
		randf_range(0.5, 1.0), randf_range(0.5, 1.0), randf_range(0.5, 1.0),
	)
	update_die_type()

func say(text: String) -> void:
	$Sayer.say(text)

func push(dir: Vector2 = Vector2(randf(), randf()),
		force: int = ROLL_FORCE) -> void:
	apply_central_force( Vector2(force, force) * dir.normalized() )

func lock() -> void:
	grab_area.active = false
	locked = true

func unlock() -> void:
	grab_area.active = true
	locked = false

func roll(
		push_dir: Vector2 = Vector2(
			randf_range(-1, 1), randf_range(-1, 1)
			)
	) -> void:
	if locked:
		return
	push(push_dir)
	update_die_nr( die.roll() )
	var roll_time: float = ROLL_TIME + randf_range(-0.05, 0.05)
	for i in 6:
		update_die_nr( die.next_face_value() )
		await get_tree().create_timer(roll_time).timeout
		roll_time *= 1.5
	update_die_nr( die.next_face_value() )
	angular_velocity = 0
	do_highlight_animation()

func do_highlight_animation(speed: float = 0.1) -> void:
	var rotation_tween: Tween = create_tween()
	rotation_tween.tween_property(
		self, "global_rotation", 0, speed
	)
	var grow_tween: Tween = create_tween()
	grow_tween.tween_property(
		self, "scale", Vector2(1.2, 1.2), speed
	)
	await grow_tween.finished
	var shrink_tween: Tween = create_tween()
	shrink_tween.tween_property(
		self, "scale"	, Vector2.ONE, speed
	)
	await shrink_tween.finished

func set_die_temp_bonus(value: int) -> void:
	die.temporary_bonus = value
	update_die_nr()

func set_die_perm_bonus(value: int) -> void:
	die.permanent_bonus = value
	update_die_nr()

func update_die_size() -> void:
	sprite.texture = Dice2Texture.d2t(die.size)
	collision_shape.shape = Dice2Texture.dice2collision(die.size)
	grab_area_collision.shape = Dice2Texture.dice2collision(die.size)

func update_die_nr(nr: int = die.get_current_face_value()) -> void:
	nr_label.text = str(nr)
	var bonus_amt: int = die.get_current_bonus()
	var bonus_text: String = str(bonus_amt)
	if bonus_amt > 0:
		bonus_text = "+" + bonus_text
	elif bonus_amt == 0:
		bonus_text = ""
	$BonusNr.text = bonus_text

func update_die_type() -> void:
	modulate = die.type.get_color()

func set_dice_tray_collision(value: bool) -> void:
	if value:
		collision_layer = 2
		collision_mask = 2
	else:
		collision_layer = 3
		collision_mask = 3

func _on_die_grab_area_end_grab(grab_area: GrabArea) -> void:
	grabbed = false
	set_dice_tray_collision(false)
	physics_material_override.bounce = 1
	lock_rotation = false
	mass = 1.0

func _on_die_grab_area_start_grab(grab_area: GrabArea) -> void:
	grabbed = true
	set_dice_tray_collision(true)
	physics_material_override.bounce = 0
	lock_rotation = true
	var tween: Tween = create_tween()
	tween.tween_property(self, "global_rotation", 0.0, 0.1)
	mass = 0.1


func _on_die_grab_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("dice_tray"):
		in_dice_tray = true
func _on_die_grab_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("dice_tray"):
		in_dice_tray = false
