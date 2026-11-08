extends Node

var word_list: WordList
var players: Array[Player]
var config: GameConfig
var curr_player: int = 0

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
