extends RefCounted
class_name ActionData

static func get_actions() -> Array[GameAction]:
	var actions: Array[GameAction] = []
	
	actions.append(GameAction.new(
		"Survive", #name
		"Scavenge and Hunt for Food", #tooltip
		[ModifierEntry.new("food", 1.0, 0.0, 1.0)], #resource modifiers
		func() -> bool: return true, #unlock condition
		func(): return, #on_unlock function
	))
	
	actions.append(GameAction.new(
		"Gather", #name
		"Collect Basic Materials", #tooltip
		[ModifierEntry.new("materials", 1.0, 0.0, 1.0)], #resource modifiers
		func() -> bool: return true, #unlock condition
		func(): return, #on_unlock function
	))
	
	
	return actions
