extends RefCounted
class_name ResourceData

static func get_resources() -> Dictionary[String, GameResource]:
	var resources: Dictionary[String, GameResource] = {}
	
	resources["food"] = GameResource.new(
		"food", #name
		"Berries and Raw Meat", #tooltip
		100, #initial amount
		true, #is_limited_resource
		1e9, #resource_pool	
		func() -> bool: return true, #unlock condition
		func(): return false, #on_unlock function
	)
	
	resources["materials"] = GameResource.new(
		"materials", #name
		"Sticks and Stones", #tooltip
		0, #initial amount
		true, #is_limited_resource
		1e9, #resource_pool	
		func() -> bool: return true, #unlock condition
		func(): return false, #on_unlock function
	)
	
	return resources
