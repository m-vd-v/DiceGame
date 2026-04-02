@abstract class_name Figurine extends Resource

signal updated(say: String)

@abstract func get_title() -> String
@abstract func get_description() -> String
@abstract func get_texture() -> Texture
func get_price() -> int: return 5

@export var value: int = 0
func should_show_value() -> bool: return false


func _on_obtain() -> void: pass

func _on_battle_start() -> void: pass

func _on_reroll() -> void: pass

func _on_before_score_die(
		_dice_scorer: DiceScorer, _current_die_node: DieNode,
		_can_rescore: bool
	) -> void: pass

func _on_after_score(_dice_scorer: DiceScorer) -> void: pass

func _on_battle_end() -> void: pass

class SnackButton extends Button:
	var button_id: StringName
	var func_to_call: Callable
	
	static func create_button(id: StringName, func2call: Callable) -> SnackButton:
		var button: SnackButton = SnackButton.new()
		button.button_id = id
		button.func_to_call = func2call
		button.pressed.connect(button._on_pressed)
		button.text = id
		return button
		
	func _on_pressed() -> void:
		func_to_call.call()

func create_buttons() -> Array[SnackButton]:
	return []
