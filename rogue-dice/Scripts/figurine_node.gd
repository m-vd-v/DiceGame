class_name FigurineNode extends Node2D

var figurine: Figurine = null
@export var starting_figurine: Figurine

@onready var texture: TextureRect = %FigurineTexture
@onready var value_label: Label = %ValueLabel

var buttons_enabled: bool = true:
	set(value):
		buttons_enabled = value
		enable_buttons(value)

func _ready() -> void:
	update_figurine(starting_figurine)

func enable_buttons(b: bool = true) -> void:
	for button: Figurine.SnackButton in %ButtonHolder.get_children():
		button.visible = b
func disable_buttons() -> void:
	enable_buttons(false)

func update(say_txt: String = "") -> void:
	update_figurine()
	if say_txt == "":
		return
	%Sayer.say(say_txt)

func update_figurine(new_figurine: Figurine = figurine) -> void:
	if new_figurine == null:
		push_warning("new_figurine is null!")
		return
	if new_figurine != figurine:
		figurine = new_figurine
		new_figurine.updated.connect(update)
	texture.texture = figurine.get_texture()
	update_value_label()
	for snack_button: Figurine.SnackButton in %ButtonHolder.get_children():
		snack_button.queue_free()
	for snack_button: Figurine.SnackButton in figurine.create_buttons():
		%ButtonHolder.add_child(snack_button)

func update_value_label() -> void:
	if figurine.should_show_value():
		value_label.visible = true
		value_label.text = str(figurine.value)
		return
	value_label.visible = false


func _on_figurine_texture_mouse_entered() -> void:
	%FigurineInfo.show_info(figurine)

func _on_figurine_texture_mouse_exited() -> void:
	%FigurineInfo.hide()
