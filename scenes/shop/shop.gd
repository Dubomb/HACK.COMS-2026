extends Control

@onready var player_label: Label = %PlayerLabel
@onready var tile_offers: HBoxContainer = %TileOffers
@onready var perk_offers: HBoxContainer = %PerkOffers
@onready var picker_label: Label = %PickerLabel
@onready var tile_picker: HFlowContainer = %TilePicker
@onready var done_button: Button = %DoneButton

var players_done: int = 0
## Index of the perk waiting for a target tile, or -1.
var pending_perk_index: int = -1

func _ready() -> void:
	# Running this scene on its own (F6): make test players with some money.
	if GameController.players.is_empty():
		var player_names: Array[String] = ["Alice", "Bob"]
		GameController.setup_players(player_names)

		for player in GameController.players:
			player.money = 30

	GameController.setup_shops()
	done_button.pressed.connect(_on_done_pressed)
	refresh()

func refresh() -> void:
	var player: Player = GameController._get_curr_player()
	var shop: Shop = GameController._get_curr_shop()

	player_label.text = "%s — $%d" % [player.display_name, player.money]

	_clear(tile_offers)
	_clear(perk_offers)
	_clear(tile_picker)

	for i in range(shop.tile_offers.size()):
		var tile: Tile = shop.tile_offers[i]
		var price: int = shop.tile_price(tile)
		var button: Button = _make_button("%s\n$%d" % [tile.get_display_name(), price], player.money < price)
		button.pressed.connect(_on_tile_offer_pressed.bind(i))
		tile_offers.add_child(button)

	for i in range(shop.perk_offers.size()):
		var perk: Perk = shop.perk_offers[i]
		var price: int = shop.perk_price(perk)
		var button: Button = _make_button("%s\n$%d" % [perk.get_display_name(), price], player.money < price)
		button.pressed.connect(_on_perk_offer_pressed.bind(i))
		perk_offers.add_child(button)

	var picking: bool = pending_perk_index != -1
	picker_label.visible = picking
	tile_picker.visible = picking

	if picking:
		for tile in player.bag.all_tiles():
			if tile.is_egg():
				continue

			var text: String = tile.get_display_name()

			if tile.perk != null:
				text += "\n" + tile.perk.get_display_name()

			var button: Button = _make_button(text, false)
			button.pressed.connect(_on_perk_target_pressed.bind(tile))
			tile_picker.add_child(button)

func _make_button(text: String, disabled: bool) -> Button:
	var button: Button = Button.new()
	button.custom_minimum_size = Vector2(140, 80)
	button.add_theme_font_size_override("font_size", 24)
	button.text = text
	button.disabled = disabled
	return button

func _clear(container: Container) -> void:
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

func _on_tile_offer_pressed(index: int) -> void:
	GameController.buy_tile(index)
	refresh()

func _on_perk_offer_pressed(index: int) -> void:
	pending_perk_index = index
	refresh()

func _on_perk_target_pressed(tile: Tile) -> void:
	GameController.buy_perk(pending_perk_index, tile)
	pending_perk_index = -1
	refresh()

func _on_done_pressed() -> void:
	GameController.end_shop_turn()
	pending_perk_index = -1
	players_done += 1

	if players_done >= GameController.players.size():
		print("Shop phase over")
		done_button.disabled = true
		return

	refresh()
