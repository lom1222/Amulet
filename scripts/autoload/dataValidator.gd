extends Node

var action_data_folder: String = "res://data/actions/"

var valid_game_modifiers: Array[String] = [
	"food_base", "food_increased", "food_multiplier",
	]
	
func validate_game_modifiers(game_modifier_list: Array[String]) -> bool:
	return game_modifier_list.all(func(modifier): return valid_game_modifiers.has(modifier))
