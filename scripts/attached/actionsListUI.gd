extends HFlowContainer

@export var action_button_scene: PackedScene
var action_data_folder = DataValidator.action_data_folder

func _ready() -> void:
	_generate_buttons()
	
func _generate_buttons():
	for child in get_children():
		child.queue_free()
		
	var dir = DirAccess.open(action_data_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.ends_with(".tres"):
				var game_action = load(action_data_folder + file_name) as GameAction
				var has_valid_mods = DataValidator.validate_game_modifiers(game_action.resource_modifiers.keys())
				LogManager.add_log("[%s] validation: [%s]" % [file_name, has_valid_mods], "sys", "green" if has_valid_mods else "red")
				_create_button(game_action)
			file_name = dir.get_next()

func _create_button(data):
	var button = action_button_scene.instantiate()
	add_child(button)
	button.setup(data)
