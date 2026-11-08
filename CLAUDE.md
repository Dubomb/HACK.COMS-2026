# Wordpocalypse

Hackathon word deckbuilder in Godot 4.7 (GDScript). Think Dominion/Balatro, but the cards are letter tiles.

## Working together

- Both developers are software engineers. Work in small chunks and only build what was asked.
- Keep classes barebones. Don't add helpers, hooks, or config options for features that aren't being built yet. Mention them instead.
- When a design question comes up, ask rather than pick a direction silently.

## Game (MVP)

- Each player starts with `starting_tiles` random letter tiles in their bag (uniform random letters).
- Turn: draw `hand_size` tiles, play one valid word, earn money equal to the sum of the played tiles' Scrabble values. Unplayed tiles go to the discard pile; when the draw pile runs out, the discard pile is shuffled back in.
- Round: every player takes a turn, then a shared shop phase where items are bought by open auction. Players control their letter mix by what they buy.
- Eggs are dead tiles you can buy. They take up hand slots and do nothing. Most eggs probably wins.
- Multiplayer is hot-seat on one device, with a pass-the-device screen if hands are hidden.
- Target platform: probably desktop (not confirmed).

**Open questions:** end-game condition, whether money carries over between rounds (`GameConfig.money_carries_over`), shop restocking, and word building order/rearranging.

**Perks** are modifiers attached to one specific tile the player chooses (like Balatro card enhancements), with rarities Void, Bronze, and Gold. Eggs come in the same three tiers. The shop offers 3 perks per round.

**Out of scope for MVP:** special/rebus tiles, word length bonuses, network multiplayer. Don't build for these yet.

## Architecture

- `scripts/core/`: game rules as plain classes (`RefCounted`, or `Resource` for config). No nodes and no UI code.
- `scenes/`: UI scenes. They read state and call into the rules; they don't hold game rules.
- `data/`: `words.txt` (ENABLE word list, public domain) and `default_config.tres`.
- Keep game state changes going through a small set of explicit actions, so a different multiplayer mode can be added later without rewriting the rules.

## Conventions

- Typed GDScript (`var x: int`, `Array[Tile]`). `snake_case` files, `PascalCase` `class_name`.
- Commit the `.gd.uid` files Godot generates next to scripts.
- `.tscn` files merge badly: one person edits a given scene at a time, keep logic in scripts, and split big screens into sub-scenes.
- Exports must include `data/*.txt` in the export preset's non-resource file filter, or the word list will be missing.

## Running things

- `godot` is on PATH (Godot 4.7.2). A Godot MCP server is also configured.
- Refresh the class cache after adding a `class_name`: `godot --headless --path . --import`
- Run a script headlessly (it must `extend SceneTree`): `godot --headless --path . -s path/to/script.gd`
