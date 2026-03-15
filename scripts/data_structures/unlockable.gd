class_name Unlockable extends RefCounted

var name: String
var tooltip: String
var icon: Texture2D
var type: String = "blank"

var unlocked: bool = false
var depreciated: bool = false

var unlock_condition: Callable
var on_unlock_function: Callable

func check_unlock_condition() -> bool:
	if unlocked:
		return true
	unlocked = unlock_condition.call()
	if unlocked:
		GlobalSignals.emit_unlockable_unlocked(self)
		on_unlock_function.call()
	return unlocked
