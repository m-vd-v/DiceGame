class_name DieValuesShower extends VBoxContainer

@export var rows: Array[HBoxContainer]

var dice_layouts: Dictionary[Die.Size, Array] = {
	Die.Size.d4: [4],
	Die.Size.d6: [6],
	Die.Size.d8: [4, 4],
	Die.Size.d10: [5, 5],
	Die.Size.d12: [6, 6],
	Die.Size.d20: [7, 7, 6]
}

func update(die: Die) -> void:
	clear()
	set_values(die)

func create_value_square(nr: int, highlight: bool) -> DieValueSquare:
	var val_sqr_pck: PackedScene = load(
		"res://ViewController/Dice/die_info/die_valueSquare.tscn"	
	)
	var val_sqr: DieValueSquare = val_sqr_pck.instantiate()
	val_sqr.set_value(nr, highlight)
	return val_sqr

func set_values(die: Die) -> void:
	var die_size: Die.Size = die.size
	var values: Array[int] = die.get_faces()
	var layout: Array = dice_layouts[die_size]
	var value_idx: int = 0
	for y in layout.size():
		var row: HBoxContainer = rows[y]
		var die_amt: int = layout[y]
		for x in die_amt:
			var highlight: bool = (value_idx == die.current_face)
			var val_sqr: DieValueSquare = create_value_square(
				values[value_idx], highlight
			)
			row.add_child(val_sqr)
			value_idx += 1
			

func clear() -> void:
	for row in rows:
		for child in row.get_children():
			row.remove_child(child)
			child.queue_free()
