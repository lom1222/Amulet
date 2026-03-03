extends Node

var active_actions: Array[GameAction] = []

signal actions_list_changed
signal action_toggled(action: GameAction)

func _ready() -> void:
	update_action_list()

func toggle_action(action: GameAction) -> bool:
	var toggle_state : bool
	if active_actions.has(action):
		active_actions.erase(action)
		toggle_state = false
	else:
		if active_actions.size() == PlayerData.data["max_simultaneous_actions"]:
			active_actions.remove_at(0)
		active_actions.append(action)
		toggle_state = true
	
	action_toggled.emit(action)
	action.update_dependant_resource_rates()
	return toggle_state

func update_action_list():
	actions_list_changed.emit()
