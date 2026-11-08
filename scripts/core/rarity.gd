class_name Rarity
extends RefCounted
## Rarity tiers for perks and eggs. Void is the common/base tier. Static only.

enum Tier { VOID, BRONZE, GOLD }

static func name_of(tier: Tier) -> String:
	return Tier.find_key(tier).capitalize()

static func random() -> Tier:
	return Tier.values().pick_random()
