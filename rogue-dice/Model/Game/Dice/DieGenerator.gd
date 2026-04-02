class_name DieGenerator

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE
}

static var modifiers: Dictionary[Rarity, Array] = {
	Rarity.COMMON: [
		DieModifierCoin.new(), DieModifierLoaded.new(), DieModifierRecycle.new(),
		DieModifierVampire.new(), DieModifierPowerUp.new(), DieModifierShiny.new()
	],
	Rarity.UNCOMMON: [
		DieModifierSnowball.new(), DieModifierPrism.new(),
		DieModifierGrow.new(), DieModifierHeal.new(),
		DieModifierFeather.new(), DieModifierPlanet.new()
	],
	Rarity.RARE: [
		DieModifierMirror.new(), DieModifierFireTornado.new(),
		DieModifierDragonCrash.new()
	]
}
static func generate_modifier(rarities: Array[Rarity]) -> DieModifier:
	var gen_modifiers: Array[DieModifier] = []
	for rarity in rarities:
		gen_modifiers.append_array(modifiers[rarity])
	return gen_modifiers.pick_random().duplicate()


static var curses: Dictionary[Rarity, Array] = {
	Rarity.COMMON: [
		DieCurseCasinoDie.new(), DieCurseMoltenSnowball.new()
	],
	Rarity.UNCOMMON: [
		DieCurseGlass.new(), DieCurseHeavy.new()
	],
	Rarity.RARE: [
		DieCurseRottenClover.new(), DieCurseUnstable.new()
	]
}
static func generate_curse(rarities: Array[Rarity]) -> DieCurse:
	var gen_curses: Array[DieCurse] = []
	for rarity in rarities:
		gen_curses.append_array(curses[rarity])
	return gen_curses.pick_random().duplicate()


static var die_types: Dictionary[Rarity, Array] = {
	Rarity.COMMON: [
		DieTypeStandard.new()
	],
	Rarity.UNCOMMON: [
		DieTypeBonus.new(), DieTypeMoney.new(),
		DieTypeMoney.new(), DieTypeStandardPlus.new()
	],
	Rarity.RARE: [
		DieTypePermabonus.new(), DieTypeBackBonus.new()
	]
}
static func generate_die_type(rarities: Array[Rarity],
			exclude_list: Array[DieType] = []) -> DieType:
	var gen_types: Array[DieType] = []
	for rarity in rarities:
		gen_types.append_array(die_types[rarity])
	var types_to_erase: Array[DieType] = []
	for exclude in exclude_list:
		for type in gen_types:
			if type.get_title() == exclude.get_title():
				types_to_erase.append(type)
	for type_to_erase in types_to_erase:
		gen_types.erase(type_to_erase)
	return gen_types.pick_random().duplicate()

static func generate_die() -> Die:
	var rarity: int = randi_range(0,
		GameManager.common_dice_rate +
		GameManager.uncommon_dice_rate +
		GameManager.rare_dice_rate
	)
	if rarity <= GameManager.common_dice_rate:
		return generate_common_die()
	if rarity <= GameManager.uncommon_dice_rate:
		return generate_uncommon_die()
	return generate_rare_die()

static func generate_shop_dice() -> Array[Die]:
	var dice: Array[Die] = []
	for i in GameManager.shop_dice_amt:
		dice.append(generate_die())
	return dice

static func generate_common_die() -> Die:
	var die: Die = Die.new()
	die.size = [
		Die.Size.d4, Die.Size.d6, Die.Size.d8
	].pick_random()
	die.permanent_bonus = randi_range(-1, 1)
	die.type = generate_die_type([Rarity.COMMON, Rarity.UNCOMMON])
	die.price = randi_range(3, 5)
	if randi_range(0, 100) < 25:
		die.curse = generate_curse([Rarity.COMMON])
	return die

static func generate_uncommon_die() -> Die:
	var die: Die = Die.new()
	die.size = [
		Die.Size.d4, Die.Size.d6, Die.Size.d8, Die.Size.d10, Die.Size.d12
	].pick_random()
	die.permanent_bonus = randi_range(2, 4)
	die.type = generate_die_type([Rarity.COMMON, Rarity.UNCOMMON])
	die.modifier1 = generate_modifier([Rarity.COMMON])
	die.price = randi_range(6, 8)
	if randi_range(0, 100) < 33:
		die.curse = generate_curse([Rarity.COMMON, Rarity.UNCOMMON])
	return die

static func generate_rare_die() -> Die:
	var die: Die = Die.new()
	die.size = [
		Die.Size.d4, Die.Size.d6, Die.Size.d8, Die.Size.d10, Die.Size.d12, Die.Size.d20
	].pick_random()
	die.permanent_bonus = randi_range(5, 8)
	die.type = generate_die_type([Rarity.COMMON, Rarity.UNCOMMON, Rarity.RARE])
	die.modifier1 = generate_modifier([Rarity.COMMON, Rarity.UNCOMMON])
	die.modifier2 = generate_modifier([Rarity.COMMON, Rarity.UNCOMMON, Rarity.RARE])
	die.price = randi_range(9, 12)
	if randi_range(0, 100) < 50:
		die.curse = generate_curse([Rarity.COMMON, Rarity.UNCOMMON, Rarity.RARE])
	return die
