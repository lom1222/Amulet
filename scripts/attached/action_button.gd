extends Button

var action_data: GameAction

func setup(data: GameAction):
	action_data = data
	text = data.name
	icon = data.icon
	tooltip_text = data.tooltip
	
func update_visuals():
	visible = action_data.unlocked and not action_data.depreciated
	modulate = Color.GREEN if action_data.is_active else Color.WHITE

func _pressed() -> void:
	ActionManager.toggle_action(action_data)
	update_visuals()
