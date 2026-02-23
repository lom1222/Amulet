extends Button

var action_data: GameAction

func setup(data: GameAction):
	action_data = data
	text = data.name
	icon = data.icon
	tooltip_text = data.tooltip

func _pressed() -> void:
	var active = ActionManager.toggle_action(action_data)
	modulate = Color.GREEN if active else Color.WHITE
