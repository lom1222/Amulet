class_name GameAction extends Unlockable

var resource_modifiers: Array[ModifierEntry]
var is_active: bool = false
var active_time: float = 0
var total_active_time: float = 0

func update(delta):
	if depreciated or not unlocked:
		return
	if is_active:
		active_time += delta
		total_active_time += delta
	else:
		active_time = 0

func update_dependant_resource_rates():
	for modifier:ModifierEntry in resource_modifiers:
		Inventory.resources[modifier.resource].update_rate_and_ui()
		
func get_save_data() -> Dictionary:
	return {
		"unlocked": unlocked,
		"depreciated": depreciated,
		"is_active": is_active,
		"active_time": active_time,
		"total_active_time": total_active_time
	}
	
func load_from_data(data):
	unlocked = data["unlocked"]
	depreciated = data["depreciated"]
	is_active = data["is_active"]
	active_time = data["active_time"]
	total_active_time = data["total_active_time"]
	
func _init(_name: String = "blank", _tooltip: String = "blank", _resource_modifiers: Array[ModifierEntry] = [], _unlock_condition: Callable = func() -> bool: return false, _on_unlock_function: Callable = func() -> bool: return false) -> void:
	type = "action"
	name = _name
	tooltip = _tooltip
	resource_modifiers = _resource_modifiers
	for modifier: ModifierEntry in resource_modifiers:
		modifier.source = _name
		modifier.source_type = "action"
	unlock_condition = _unlock_condition
	on_unlock_function = _on_unlock_function
