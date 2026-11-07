class_name WordList
extends RefCounted
## Set of valid words, loaded from a file with one word per line. Stored uppercase.

const DEFAULT_PATH := "res://data/words.txt"

var _words: Dictionary[String, bool] = {}


func _init(path: String = DEFAULT_PATH) -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Could not open word list: %s" % path)
		return
	for line in file.get_as_text().split("\n", false):
		_words[line.strip_edges().to_upper()] = true


func is_valid(word: String) -> bool:
	return _words.has(word.to_upper())
