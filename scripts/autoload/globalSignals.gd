extends Node

signal resource_unlocked(resource: GameResource)
signal resource_tooltip_changed(resource: GameResource)
signal game_ready
signal action_unlocked(action: GameAction)

func emit_resource_unlocked(resource: GameResource):
	resource_unlocked.emit(resource)
	
func emit_resource_tooltip_changed(resource: GameResource):
	resource_tooltip_changed.emit(resource)

func emit_game_ready():
	game_ready.emit()
	
func emit_action_unlocked(action: GameAction):
	action_unlocked.emit(action)
	
func emit_unlockable_unlocked(unlockable: Unlockable):
	if unlockable is GameAction:
		emit_action_unlocked(unlockable)
	elif unlockable is GameResource:
		emit_resource_unlocked(unlockable)
	else:
		return false
