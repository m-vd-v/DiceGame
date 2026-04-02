class_name FigurineGenerator

static var figurines: Array[Figurine] = [
	FigurineGoldStatue.new(), FigurineReroll.new(), FigurineGoldenReroll.new(),
	FigurineStandardPower.new(), FigurineEmperorPenguin.new()
]

static func generate_figurine() -> Figurine:
	return figurines.pick_random().duplicate()

static func generate_shop_figurines() -> Array[Figurine]:
	var figs: Array[Figurine] = []
	for i in 2:
		figs.append(generate_figurine())
	return figs
