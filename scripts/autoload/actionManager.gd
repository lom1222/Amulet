extends Node

var active_actions: Array[GameAction] = []

signal actions_list_changed
signal action_toggled(action: GameAction)

var game_actions: Array[GameAction] = []

func _ready() -> void:
	game_actions = ActionData.get_actions()
	update_action_list()
	GlobalSignals.game_ready.connect(_on_game_ready)

func _process(delta: float) -> void:
	for action: GameAction in game_actions:
		action.update(delta)
	return

func toggle_action(action: GameAction) -> bool:
	if active_actions.has(action):
		active_actions.erase(action)
		action.is_active = false
	else:
		if active_actions.size() == PlayerData.max_simultaneous_actions:
			var removed_action = active_actions.pop_front()
			removed_action.is_active = false
			removed_action.update_dependant_resource_rates()
			action_toggled.emit(removed_action)
		active_actions.append(action)
		action.is_active = true
	
	action_toggled.emit(action)
	action.update_dependant_resource_rates()
	update_action_list()
	return action.is_active

func update_action_list():
	actions_list_changed.emit()

func _check_for_active_actions():
	for action in game_actions:
		if action.is_active:
			active_actions.append(action)
			action.update_dependant_resource_rates()
	
func _on_game_ready():
	_check_for_active_actions()
