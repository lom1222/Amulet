class_name GameAction extends Unlockable

var resource_modifiers: Array[ModifierEntry]

func update_dependant_resource_rates():
	for modifier:ModifierEntry in resource_modifiers:
		Inventory.resources[modifier.resource].update_rate_and_ui()
	
func _init(_name: String = "blank", _tooltip: String = "blank", _resource_modifiers: Array[ModifierEntry] = [], _unlock_condition: Callable = func() -> bool: return false, _on_unlock_function: Callable = func() -> bool: return false) -> void:
	type = "action"
	name = _name
	tooltip = _tooltip
	resource_modifiers = _resource_modifiers
	unlock_condition = _unlock_condition
	on_unlock_function = _on_unlock_function
