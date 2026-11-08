class_name Egg
extends Tile

var rarity: Rarity.Tier

func _init(p_rarity: Rarity.Tier) -> void:
	super(Kind.EGG)
	rarity = p_rarity

func get_display_name() -> String:
	if rarity == Rarity.Tier.VOID:
		return "Egg"

	return "%s Egg" % Rarity.name_of(rarity)
