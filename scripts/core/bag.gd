class_name Bag
extends RefCounted
## A player's tiles outside their hand: a draw pile and a discard pile.

var draw_pile: Array[Tile] = []
var discard_pile: Array[Tile] = []


func _init(starting_tiles: Array[Tile]) -> void:
	draw_pile.assign(starting_tiles)
	draw_pile.shuffle()


## Draws up to `count` tiles, reshuffling the discard pile in when the draw pile runs out.
func draw(count: int) -> Array[Tile]:
	var drawn: Array[Tile] = []
	while drawn.size() < count:
		if draw_pile.is_empty():
			if discard_pile.is_empty():
				break
			draw_pile.append_array(discard_pile)
			discard_pile.clear()
			draw_pile.shuffle()
		drawn.append(draw_pile.pop_back())
	return drawn


func discard(tiles: Array[Tile]) -> void:
	discard_pile.append_array(tiles)


func all_tiles() -> Array[Tile]:
	return draw_pile + discard_pile


## New tiles (e.g. bought) go to the discard pile.
func add(tile: Tile) -> void:
	discard_pile.append(tile)
