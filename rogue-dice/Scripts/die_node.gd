class_name DieNode extends RigidBody2D

const ROLL_FORCE: int = 150 * 1000
const ROLL_TIME: float = 0.1

@export var grab_area: DieGrabArea

@onready var sprite: Sprite2D = $DieSprite
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var grab_area_collision: CollisionShape2D = $DieGrabArea/GrabCollision
@onready var nr_label: Label = $DieSprite/CenterContainer/NumberLabel

@onready var t_bonus_label: Label = $DieSprite/TempBonusLabel
@onready var p_bonus_label: Label = $DieSprite/PermBonusLabel
@onready var die_info: DieInfo = $DieSprite/DieInfo

@onready var mod_sprite1: TextureRect = $ModifierSprite1
@onready var mod_sprite2: TextureRect = $ModifierSprite2
@onready var curse_sprite: TextureRect = $CurseSprite

@onready var lock_icon: TextureRect = $LockIcon

@export var die: Die

var locked: bool = false

var in_dice_tray: bool = false
var grabbed: bool = false

func _ready() -> void:
	update_die_size()
	update_die_nr(die.roll())
	sprite.modulate = Color(
		randf_range(0.5, 1.0), randf_range(0.5, 1.0), randf_range(0.5, 1.0),
	)
	update_die_type()
	update_modifier_sprites()

func say(text: String) -> void:
	$Sayer.say(text)

func push(dir: Vector2 = Vector2(randf(), randf()),
		force: int = ROLL_FORCE) -> void:
	apply_central_force( Vector2(force, force) * dir.normalized() )

func lock() -> void:
	grab_area.active = false
	lock_icon.visible = true
	locked = true

func unlock() -> void:
	grab_area.active = true
	lock_icon.visible = false
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
	var roll_time: float = ROLL_TIME + randf_range(-0.02, 0.02)
	for i in 6:
		update_die_nr( die.next_face_value() )
		await get_tree().create_timer(roll_time).timeout
		roll_time *= 1.5
	angular_velocity = 0
	update_die_nr( die.next_face_value() )
	for effect: DieEffect in die.get_die_effects():
		effect._replace_roll(self)
	for effect: DieEffect in die.get_die_effects():
		effect._after_reroll(self)
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

func destroy() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(
		self, "scale", Vector2.ZERO, 0.5
	).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	await tween.finished
	get_parent().remove_child(self)
	GameManager.recalculate_dice_amt()
	queue_free()

func set_die_temp_bonus(value: int) -> void:
	die.temporary_bonus = value
	update_die_nr()
func add_temp_bonus(value: int, update_modifiers: bool = true) -> void:
	set_die_temp_bonus( die.temporary_bonus + value )
	if not update_modifiers: return
	for effect in die.get_die_effects():
		effect._on_gain_temp_bonus(self, value)

func set_die_perm_bonus(value: int) -> void:
	die.permanent_bonus = value
	update_die_nr()
func add_perm_bonus(value: int, update_modifiers: bool = true) -> void:
	set_die_perm_bonus( die.permanent_bonus + value )
	if not update_modifiers: return
	for effect in die.get_die_effects():
		effect._on_gain_perm_bonus(self, value)

func update_die_size() -> void:
	sprite.texture = Dice2Texture.d2t(die.size)
	collision_shape.shape = Dice2Texture.dice2collision(die.size)
	grab_area_collision.shape = Dice2Texture.dice2collision(die.size)

func update_die_nr(nr: int = die.get_current_face_value()) -> void:
	nr_label.text = str(nr)
	var t_bonus_amt: int = die.temporary_bonus
	var t_bonus_text: String = str(t_bonus_amt)
	if t_bonus_amt > 0:
		t_bonus_text = "+" + t_bonus_text
	elif t_bonus_amt == 0:
		t_bonus_text = ""
	t_bonus_label.text = t_bonus_text
	var p_bonus_amt: int = die.permanent_bonus
	var p_bonus_text: String = str(p_bonus_amt)
	if p_bonus_amt > 0:
		p_bonus_text = "+" + p_bonus_text
	elif p_bonus_amt == 0:
		p_bonus_text = ""
	p_bonus_label.text = p_bonus_text

func update_die_type() -> void:
	sprite.modulate = die.type.get_color()

func update_modifier_sprites() -> void:
	mod_sprite1.texture = die.modifier1.get_icon()
	mod_sprite2.texture = die.modifier2.get_icon()
	curse_sprite.texture = die.curse.get_icon()

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


func _on_die_grab_area_start_hover() -> void:
	die_info.show_info(die)

func _on_die_grab_area_end_hover() -> void:
	die_info.hide_info()
