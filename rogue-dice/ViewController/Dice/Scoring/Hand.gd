class_name Hands

class Type:
	var name: String
	var multiplier: float
	func _init(_name: String, _multiplier: float) -> void:
		name = _name
		multiplier = _multiplier

static var NONE: Type = Type.new("None", 0.0)
static var HIGH_DIE: Type = Type.new("High Die", 1.0)
static var PAIR: Type = Type.new("Pair", 1.5)
static var TWO_PAIR: Type = Type.new("Two Pair", 2.0)
static var THREE_OAK: Type = Type.new("Three of a Kind", 2.0)
static var SHORT_STRAIGHT: Type = Type.new("Short Straight", 2.0)
static var FULL_HOUSE: Type = Type.new("Full House", 2.5)
static var FOUR_OAK: Type = Type.new("Four of a Kind", 3.0)
static var LONG_STRAIGHT: Type = Type.new("Long Straight", 4.0)
static var FIVE_OAK: Type = Type.new("Five of a Kind", 5.0)

static var DOUBLE_3OAK: Type = Type.new("Double Triple", 5.0)
static var FULLER_HOUSE: Type = Type.new("Fuller House", 5.0)
static var THREE_PAIR: Type = Type.new("Three Pair", 3.0)
static var LONGEST_STRAIGHT: Type = Type.new("Longest Straight", 8.0)
static var SIX_OAK: Type = Type.new("Six of a Kind", 10.0)

static func get_hand_type_from_die_nodes(die_nodes: Array[DieNode]) -> Type:
	var faces: Array[int] = []
	for die_node in die_nodes:
		faces.append(die_node.die.get_current_face_value())
	return get_hand_type(faces)

static func get_hand_type(faces: Array[int]) -> Type:
	if faces.is_empty(): return NONE
	var frequencies: Dictionary[int, int] = get_face_frequencies(faces)
	var freq_arr: Array[int] = frequencies.values()
	var included_numbers: Array[int] = frequencies.keys()
	if is_6OAK(freq_arr): return SIX_OAK
	if is_longest_straight(included_numbers): return LONGEST_STRAIGHT
	if is_5OAK(freq_arr): return FIVE_OAK
	if is_fuller_house(freq_arr): return FULLER_HOUSE
	if is_long_straight(included_numbers): return LONG_STRAIGHT
	if is_double_triple(freq_arr): return DOUBLE_3OAK
	if is_4OAK(freq_arr): return FOUR_OAK
	if is_short_straight(included_numbers): return SHORT_STRAIGHT
	if is_three_pair(freq_arr): return THREE_PAIR
	if is_full_house(freq_arr): return FULL_HOUSE
	if is_3OAK(freq_arr): return THREE_OAK
	if is_two_pair(freq_arr): return TWO_PAIR
	if is_pair(freq_arr): return PAIR
	return HIGH_DIE

static func get_face_frequencies(faces: Array[int]) -> Dictionary[int, int]:
	var frequencies: Dictionary[int, int] = {}
	for face in faces:
		if frequencies.has(face):
			frequencies[face] += 1
		else:
			frequencies[face] = 1
	return frequencies

static func get_highest(freq_arr: Array[int], amt: int) -> Array[int]:
	var fa: Array[int] = freq_arr.duplicate()
	var highest_nrs: Array[int] = []
	for i in amt:
		if fa.is_empty():
			highest_nrs.append(0)
			continue
		var max_location: int = fa.find(fa.max())
		highest_nrs.append(fa.pop_at(max_location))
	return highest_nrs

static func is_two_pair(frequency_arr: Array[int]) -> bool:
	var two_highest: Array[int] = get_highest(frequency_arr, 2)
	return (two_highest[0] >= 2 and two_highest[1] >= 2)
static func is_three_pair(frequency_arr: Array[int]) -> bool:
	var highest: Array[int] = get_highest(frequency_arr, 3)
	return (
		highest[0] >= 2 and highest[1] >= 2 and highest[2] >= 2
	)
static func is_double_triple(frequency_arr: Array[int]) -> bool:
	var highest: Array[int] = get_highest(frequency_arr, 2)
	return (
		highest[0] >= 3 and highest[1] >= 3
	)
	
static func is_full_house(frequency_arr: Array[int]) -> bool:
	var two_highest: Array[int] = get_highest(frequency_arr, 2)
	return (two_highest[0] >= 3 and two_highest[1] >= 2)
static func is_fuller_house(frequency_arr: Array[int]) -> bool:
	var two_highest: Array[int] = get_highest(frequency_arr, 2)
	return (two_highest[0] >= 4 and two_highest[1] >= 2)

static func is_pair(frequency_arr: Array[int]) -> bool:
	return frequency_arr.max() >= 2
static func is_3OAK(frequency_arr: Array[int]) -> bool:
	return frequency_arr.max() >= 3
static func is_4OAK(frequency_arr: Array[int]) -> bool:
	return frequency_arr.max() >= 4
static func is_5OAK(frequency_arr: Array[int]) -> bool:
	return frequency_arr.max() >= 5
static func is_6OAK(frequency_arr: Array[int]) -> bool:
	return frequency_arr.max() >= 6

static func is_short_straight(included_faces: Array[int]) -> bool:
	return get_longest_straight_len(included_faces) >= 4
static func is_long_straight(included_faces: Array[int]) -> bool:
	return get_longest_straight_len(included_faces) >= 5
static func is_longest_straight(included_faces: Array[int]) -> bool:
	return get_longest_straight_len(included_faces) >= 6

static func get_longest_straight_len(numbers: Array[int]) -> int:
	var longest: int = 0
	var current_streak: int = 0
	for nr in numbers:
		current_streak = 1
		var next: int = nr
		while true:
			next += 1
			if numbers.has(next):
				current_streak += 1
			else:
				break
		if current_streak > longest:
			longest = current_streak	
	return longest
