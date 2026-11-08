class_name Shop
extends RefCounted

var config: GameConfig
var tile_offers: Array[Tile] = []
var perk_offers: Array[Perk] = []

func _init(p_config: GameConfig) -> void:
	config = p_config

func roll() -> void:
	tile_offers.clear()
	perk_offers.clear()

	for i in range(config.shop_tile_count):
		var letter: String = LetterTable.random_letter()
		tile_offers.append(LetterTable.make_tile(letter))

	for rarity in config.egg_prices:
		tile_offers.append(Egg.new(rarity))

	for i in range(config.shop_perk_count):
		perk_offers.append(Perk.new(Rarity.random()))

func tile_price(tile: Tile) -> int:
	if tile is Egg:
		return config.egg_prices[tile.rarity]

	if LetterTable.VOWELS.has(tile.letter):
		return config.vowel_price

	var max_values: Array = config.consonant_prices.keys()
	max_values.sort()

	for max_value in max_values:
		if tile.value <= max_value:
			return config.consonant_prices[max_value]

	push_error("No consonant price for tile value %d" % tile.value)
	return 0

func perk_price(perk: Perk) -> int:
	return config.perk_prices[perk.rarity]

func buy_tile(player: Player, index: int) -> bool:
	var tile: Tile = tile_offers[index]
	var price: int = tile_price(tile)

	if player.money < price:
		return false

	player.money -= price
	player.bag.add(tile)
	tile_offers.remove_at(index)

	return true

## Attaches the perk to `target`, replacing any perk it already had.
func buy_perk(player: Player, index: int, target: Tile) -> bool:
	var perk: Perk = perk_offers[index]
	var price: int = perk_price(perk)

	if player.money < price:
		return false

	player.money -= price
	target.perk = perk
	perk_offers.remove_at(index)

	return true
