extends Node

var unlockable_list: Array[Unlockable] = []

func _ready() -> void:
	unlockable_list = _collect_unlockables()
	_set_unlock_check_timer()

func _set_unlock_check_timer():
	var unlock_check_timer =  Timer.new()
	add_child(unlock_check_timer)
	unlock_check_timer.wait_time = ConfigManager.configs["UNLOCK_CHECK_FREQUENCY"]
	unlock_check_timer.autostart = true
	unlock_check_timer.timeout.connect(_on_unlock_check_timer_timeout)
	unlock_check_timer.start()
	return

func _collect_unlockables() -> Array[Unlockable]:
	var unlockables: Array[Unlockable] = []
	unlockables.append_array(_get_unlockable_resources())
	unlockables.append_array(_get_unlockable_actions())
	return unlockables
	
func _get_unlockable_resources() -> Array[Unlockable]:
	var unlockable_resources: Array[Unlockable] = []
	for resource:GameResource in  Inventory.resources.values():
		if not resource.unlocked:
			unlockable_resources.append(resource)
	return unlockable_resources

func _get_unlockable_actions() -> Array[Unlockable]:
	var unlockable_actions: Array[Unlockable] = []
	for action:GameAction in ActionManager.game_actions:
		if not action.unlocked:
			unlockable_actions.append(action)
	return unlockable_actions

func _on_unlock_check_timer_timeout():
	var unlockables_to_remove = []
	for unlockable: Unlockable in unlockable_list:
		var unlocked = unlockable.check_unlock_condition()
		if unlocked:
			unlockables_to_remove.append(unlockable)
	for unlockable: Unlockable in unlockables_to_remove:
		unlockable_list.erase(unlockable)
