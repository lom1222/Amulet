extends HFlowContainer

@export var action_button_scene: PackedScene
var action_data_folder = DataValidator.action_data_folder

func _ready() -> void:
	_generate_buttons()
	
func _generate_buttons():
	for child in get_children():
		child.queue_free()
	
	var game_actions = ActionManager.game_actions
	
	for game_action: GameAction in game_actions:
		var has_valid_names = DataValidator.validate_resource_names(game_action.resource_modifiers)
		LogManager.add_log("[%s] validation: [%s]" % [game_action.name, has_valid_names], "sys", "green" if has_valid_names else "red")
		_create_button(game_action)

func _create_button(data):
	var button = action_button_scene.instantiate()
	add_child(button)
	button.setup(data)
