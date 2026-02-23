extends RefCounted
class_name GameResource

var name: String = "blank"
var tooltip: String = "blank"
var amount: float = 0.0
var rate: float = 0.0

var unlocked: bool = false
var rate_enabled: bool = false
var depreciated: bool = false

var is_limited_resource: bool = true
var resource_pool: float = 0

var base_rate: float = 0
var increased_multiplier: float = 1
var base_rate_modifiers: Dictionary[String, float] = {
	"Base": 0
}
var increased_multiplier_modifiers: Dictionary[String, float] = {
	"Base": 1
}
var multipliers: Dictionary[String, float] = {
	"Base": 1
}

func update(delta):
	var resource_delta = rate*delta
	if rate_enabled and not depreciated:
		if is_limited_resource and resource_pool < resource_delta:
			resource_delta = resource_pool
		amount += resource_delta
		
func checkRate():
	#check all buildings, upgrades, and actions for rate modifications
	rate = _get_new_rate()
	tooltip = _generate_tooltip()
	
	
func _get_new_rate() -> float:
	if not rate_enabled:
		return 0.0
	base_rate = _get_base_rate()
	increased_multiplier = _get_increased_multiplier()
	var new_rate = base_rate * increased_multiplier
	for mult in multipliers.values:
		new_rate *= mult
	return new_rate
	
func _get_base_rate() -> float:
	return 0
	
func _get_increased_multiplier() -> float:
	return 1
	
func _generate_tooltip():
	return
	
func get_save_data() -> Dictionary:
	return {
		"amount": amount,
		"unlocked": unlocked,
		"rate_enabled": rate_enabled,
		"depreciated": depreciated,
		"is_limited_resource": is_limited_resource,
		"resource_pool": resource_pool
	}
	
func load_from_data(data):
	amount = data["amount"]
	unlocked = data["unlocked"]
	rate_enabled = data["rate_enabled"]
	depreciated = data["depreciated"]
	is_limited_resource = data["is_limited_resource"]
	resource_pool = data["resource_pool"]
