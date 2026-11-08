class_name Tile
extends RefCounted
## A tile a player owns: a letter worth money, or an egg (see Egg).

enum Kind { LETTER, EGG }

var kind: Kind
var letter: String
var value: int
var perk: Perk = null


func _init(p_kind: Kind, p_letter: String = "", p_value: int = 0) -> void:
	kind = p_kind
	letter = p_letter
	value = p_value


func is_egg() -> bool:
	return kind == Kind.EGG


func get_display_name() -> String:
	return letter
