class_name Player
extends RefCounted

var display_name: String
var money: int = 0
var bag: Bag
var hand: Array[Tile] = []


func _init(p_display_name: String, p_bag: Bag) -> void:
	display_name = p_display_name
	bag = p_bag


func draw_hand(count: int) -> void:
	hand.append_array(bag.draw(count))


func discard_hand() -> void:
	bag.discard(hand)
	hand.clear()
