class_name BossGenerator

static var bosses: Array[Boss] = [
	BossSquareWheel.new()
]

static func generate_boss() -> Boss:
	return bosses.pick_random().duplicate()
