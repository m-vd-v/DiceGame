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

func update(die_size: Die.Size, values: Array[int]) -> void:
	clear()
	set_values(die_size, values)

func create_value_square(nr: int) -> DieValueSquare:
	var val_sqr_pck: PackedScene = load(
		"res://ViewController/Dice/die_info/die_valueSquare.tscn"	
	)
	var val_sqr: DieValueSquare = val_sqr_pck.instantiate()
	val_sqr.set_value(nr)
	return val_sqr

func set_values(die_size: Die.Size, values: Array[int]) -> void:
	var layout: Array = dice_layouts[die_size]
	var value_idx: int = 0
	for y in layout.size():
		var row: HBoxContainer = rows[y]
		var die_amt: int = layout[y]
		for x in die_amt:
			row.add_child(
				create_value_square( values[value_idx] )
			)
			value_idx += 1
			

func clear() -> void:
	for row in rows:
		for child in row.get_children():
			row.remove_child(child)
			child.queue_free()
