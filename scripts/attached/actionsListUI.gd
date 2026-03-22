extends HFlowContainer

@export var action_button_scene: PackedScene
var action_data_folder = DataValidator.action_data_folder

func _ready() -> void:
	ActionManager.actions_list_changed.connect(_on_action_list_changed)
	GlobalSignals.action_unlocked.connect(_on_action_unlocked)
	_generate_buttons()
	_update_all_button_visuals()

func _update_all_button_visuals():
	for child in get_children():
		child.update_visuals()
	
func _generate_buttons():
	for child in get_children():
		child.queue_free()
	
	var game_actions = ActionManager.game_actions
	
	for game_action: GameAction in game_actions:
		var has_valid_names = DataValidator.validate_resource_names(game_action.resource_modifiers)
		LogManager.add_log("Action [%s] validation: [%s]" % [game_action.name, has_valid_names], "sys", "green" if has_valid_names else "red")
		_create_button(game_action)

func _create_button(data):
	var button = action_button_scene.instantiate()
	add_child(button)
	button.setup(data)
	
func _on_action_list_changed():
	_update_all_button_visuals()

func _on_action_unlocked(_action):
	_update_all_button_visuals()
