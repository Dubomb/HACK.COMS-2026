class_name GameConfig
extends Resource
## Tunable rules. Values live in res://data/default_config.tres.

@export var starting_vowels: int = 3
@export var starting_consonants: int = 7
@export var hand_size: int = 10
@export var money_carries_over: bool = true

@export_group("Shop")
@export var shop_tile_count: int = 5
@export var shop_perk_count: int = 3
@export var vowel_price: int = 3
## Maps a max tile value to a consonant's price. A consonant uses the entry with
## the smallest key at or above its value: {2: 2, 5: 8, 10: 13} means values 1-2
## cost $2, 3-5 cost $8, and 6-10 cost $13.
@export var consonant_prices: Dictionary[int, int] = {2: 2, 5: 8, 10: 13}
## One egg of each rarity listed here is offered in every shop.
@export var egg_prices: Dictionary[Rarity.Tier, int] = {
	Rarity.Tier.VOID: 8,
	Rarity.Tier.BRONZE: 16,
	Rarity.Tier.GOLD: 24,
}
@export var perk_prices: Dictionary[Rarity.Tier, int] = {
	Rarity.Tier.VOID: 5,
	Rarity.Tier.BRONZE: 10,
	Rarity.Tier.GOLD: 15,
}
