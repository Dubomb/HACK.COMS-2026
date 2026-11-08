extends Node

var word_list: WordList
var players: Array[Player]
var shops: Array[Shop]
var config: GameConfig
var curr_player_index: int = 0

func _ready() -> void:
	word_list = WordList.new()
	config = load("res://data/default_config.tres")


func setup_players(player_names: Array[String]) -> void:
	for player_name in player_names:
		var starting_tiles: Array[Tile] = []
		
		for i in range(config.starting_vowels):
			var letter: String = LetterTable.random_vowel()
			starting_tiles.append(LetterTable.make_tile(letter))
		
		for i in range(config.starting_consonants):
			var letter: String = LetterTable.random_consonant()
			starting_tiles.append(LetterTable.make_tile(letter))
		
		var bag: Bag = Bag.new(starting_tiles)
		var player: Player = Player.new(player_name, bag)
		players.append(player)

func _get_curr_player() -> Player:
	return players[curr_player_index]

func start_turn() -> void:
	var curr_player: Player = _get_curr_player()
	curr_player.draw_hand(config.hand_size)

func submit_word(word: String, used_tiles: Array[Tile]) -> bool:
	if not word_list.is_valid(word):
		return false
	
	var curr_player: Player = _get_curr_player()
	var score: int = 0
	
	for tile in used_tiles:
		score += tile.value
	
	curr_player.money = score
	
	return true

func end_turn() -> void:
	var curr_player = _get_curr_player()
	curr_player.discard_hand()
	
	curr_player_index += 1
	curr_player_index %= players.size()

func setup_shops() -> void:
	shops.clear()
	
	for player in players:
		var shop: Shop = Shop.new(config)
		shop.roll()
		shops.append(shop)

func _get_curr_shop() -> Shop:
	return shops[curr_player_index]

func buy_tile(index: int) -> bool:
	return _get_curr_shop().buy_tile(_get_curr_player(), index)

func buy_perk(index: int, target: Tile) -> bool:
	return _get_curr_shop().buy_perk(_get_curr_player(), index, target)

func end_shop_turn() -> void:
	curr_player_index += 1
	curr_player_index %= players.size()
