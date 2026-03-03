extends Node

var action_data_folder: String = "res://data/actions/"

var valid_game_modifiers: Array[String] = [
	"food_base", "food_increased", "food_multiplier",
	]
	
func validate_game_modifiers(game_modifier_list: Array[String]) -> bool:
	return game_modifier_list.all(func(modifier:String): return valid_game_modifiers.has(modifier))
	
func validate_resource_names(modifiers: Array[ModifierEntry]) -> bool:
	var names : Array[String] = []
	for modifier: ModifierEntry in modifiers:
		names.append(modifier.resource)
	return names.all(func(resource:String): return Inventory.RESOURCE_LIST.has(resource))
