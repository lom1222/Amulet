extends Node

var game_time: float = 0
var max_simultaneous_actions: int = 1
var population: float = 1

func _process(delta: float) -> void:
	game_time += delta

func initialize_player_data():
	return true
	
func get_save_data() -> Dictionary[String, float]:
	return {
		"game_time": game_time,
		"max_simultaneous_actions": max_simultaneous_actions,
		"population": population,
	}
	
func load_from_data(data: Dictionary[String, float]):
	game_time = data["game_time"]
	max_simultaneous_actions = int(data["max_simultaneous_actions"])
	population = data["population"]
	return
