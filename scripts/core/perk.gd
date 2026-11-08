class_name Perk
extends RefCounted
## A modifier attached to one tile. Base class: subclass it to give a perk an effect.

var rarity: Rarity.Tier

func _init(p_rarity: Rarity.Tier) -> void:
	rarity = p_rarity

func get_display_name() -> String:
	return "%s Perk" % Rarity.name_of(rarity)
