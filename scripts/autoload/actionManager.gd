extends Node

var active_actions: Array[GameAction] = []

signal actions_list_changed

func _ready() -> void:
	update_action_list()

func toggle_action(action: GameAction) -> bool:
	if active_actions.has(action):
		active_actions.erase(action)
		return false
	if active_actions.size() == PlayerData.data["max_simultaneous_actions"]:
		active_actions.remove_at(0)
	active_actions.append(action)
	return true

func update_action_list():
	actions_list_changed.emit()
