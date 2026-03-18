class_name Die extends Resource

enum Size {
	d4 = 4,
	d6 = 6,
	d8 = 8,
	d10 = 10,
	d12 = 12,
	d20 = 20
}

@export var size: Die.Size = Size.d4
@export var type: DieType = DieTypeStandard.new()
@export var faces: Array[int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

@export var permanent_bonus: int = 0
@export var temporary_bonus: int = 0

var current_face: int = get_random_face()

func get_current_bonus() -> int:
	return permanent_bonus + temporary_bonus

func get_current_value_with_bonus() -> int:
	return get_current_face_value() + get_current_bonus()

func get_current_face_value() -> int:
	return faces[current_face]

func next_face() -> int:
	current_face = (current_face + 1) % size
	return current_face

func next_face_value() -> int:
	return(faces[next_face()])

func get_faces() -> Array[int]:
	return faces.slice(0, size)

func get_random_face() -> int:
	return randi_range(0, size-1)

func roll(face: int = get_random_face()) -> int:
	var rolled_value: int = faces[face]
	current_face = face
	return rolled_value

func get_max_value() -> int:
	var max_val: int = faces[0]
	for i in size:
		max_val = max(i, max_val)
	return max_val

func get_min_value() -> int:
	var min_val: int = faces[0]
	for i in size:
		min_val = min(i, min_val)
	return min_val
