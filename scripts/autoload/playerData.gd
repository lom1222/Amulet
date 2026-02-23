extends Node

var data: Dictionary[String, float] = {
	"game_time" = 0,
	"max_simultaneous_actions" = 1,
	"population" = 1
}

func _process(delta: float) -> void:
	data["game_time"] += delta

func initialize_player_data():
	return true
