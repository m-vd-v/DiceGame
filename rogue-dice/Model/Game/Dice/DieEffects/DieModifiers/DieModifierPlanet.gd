class_name DieModifierPlanet extends DieModifier

func get_title() -> String:
	return "Planet"
func get_description() -> String:
	return "Adds +0.1x to the Hand Type this die is in whenever this die scores."
func get_icon() -> Texture:
	return load("res://Assets/Images/Sprites/DieModifiers/Planet.png")

func _after_score(dice_scorer: DiceScorer, _can_rescore: bool) -> void:
	dice_scorer.current_hand_type.multiplier += 0.1
