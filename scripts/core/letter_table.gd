class_name LetterTable
extends RefCounted
## Scrabble letter values. Static only.

const VALUES: Dictionary[String, int] = {
	"A": 1, "B": 3, "C": 3, "D": 2, "E": 1, "F": 4, "G": 2, "H": 4, "I": 1,
	"J": 8, "K": 5, "L": 1, "M": 3, "N": 1, "O": 1, "P": 3, "Q": 10, "R": 1,
	"S": 1, "T": 1, "U": 1, "V": 4, "W": 4, "X": 8, "Y": 4, "Z": 10,
}

const VOWELS: Array[String] = ["A", "E", "I", "O", "U"]
const CONSONANTS: Array[String] = [
	"B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N",
	"P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"
]

static func make_tile(letter: String) -> Tile:
	return Tile.new(Tile.Kind.LETTER, letter, VALUES[letter])


static func random_letter() -> String:
	return VALUES.keys().pick_random()


static func random_vowel() -> String:
	return VOWELS.pick_random()

static func random_consonant() -> String:
	return CONSONANTS.pick_random()
