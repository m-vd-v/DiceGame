class_name Dice2Texture

static func d2t(die_size: Die.Size) -> Texture:
	match die_size:
		Die.Size.d4: return load("res://Assets/Images/Sprites/Dice/d4.svg")
		Die.Size.d6: return load("res://Assets/Images/Sprites/Dice/d6.svg")
		Die.Size.d8: return load("res://Assets/Images/Sprites/Dice/d8.svg")
		Die.Size.d10: return load("res://Assets/Images/Sprites/Dice/d10.svg")
		Die.Size.d12: return load("res://Assets/Images/Sprites/Dice/d12.svg")
		Die.Size.d20: return load("res://Assets/Images/Sprites/Dice/d20.svg")
		_: return load("res://Assets/Images/Sprites/Dice/d4.svg")
		
static func dice2collision(die_size: Die.Size) -> Shape2D:
	return load(
		"res://ViewController/Globals/Utilities/DiceNodeCollisionShapes/" +
		"d" + str(die_size) + ".tres"
	)
