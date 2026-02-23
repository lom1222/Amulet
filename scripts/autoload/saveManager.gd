extends Node

const SAVE_FILE_PATH = "user://save_0.cfg"

func _ready() -> void:
	var auto_save_timer =  Timer.new()
	add_child(auto_save_timer)
	auto_save_timer.wait_time = ConfigManager.configs["auto_save_frequency"]
	auto_save_timer.autostart = true
	auto_save_timer.timeout.connect(_on_auto_save_timer_timeout)
	auto_save_timer.start()
	var game_loaded = _load_game()
	if not game_loaded:
		_initialize_game_data()

func save_game():
	if ConfigManager.configs["DISABLE_SAVING"]:
		return
	var save_file = ConfigFile.new()
	
	for resource_name in Inventory.resources:
		save_file.set_value("Resources", resource_name, Inventory.resources[resource_name].get_save_data())
	
	for data_value in PlayerData.data:
		save_file.set_value("Player", data_value, PlayerData.data[data_value])
	
	save_file.set_value("Meta", "save_time", Time.get_unix_time_from_system())
	
	save_file.save(SAVE_FILE_PATH)
	LogManager.add_log("Game Saved Successfully: [%s]" % [SAVE_FILE_PATH], "sys", "green")

func _load_game():
	if ConfigManager.configs["DISABLE_LOADING"]:
		return false
	var save_file = ConfigFile.new()
	var err = save_file.load(SAVE_FILE_PATH)
	
	if err == OK:
		for resource_name in Inventory.resources:
			Inventory.resources[resource_name].load_from_data(save_file.get_value("Resources", resource_name, Inventory.resources[resource_name].get_save_data()))
		
		for data_value in PlayerData.data:
			PlayerData.data[data_value] = save_file.get_value("Player", data_value, PlayerData.data[data_value])
		
		var cur_time = Time.get_unix_time_from_system()
		var _time_since_last_save = cur_time - save_file.get_value("Meta", "save_time", cur_time)
		
		LogManager.add_log("[%s]: [err: %s] , loaded succesfully" % [SAVE_FILE_PATH, err], "sys", "green")
		return true
	LogManager.add_log("error with [%s]: [err: %s] , initializing game" % [SAVE_FILE_PATH, err], "sys", "red")
	return false
	

func _initialize_game_data():
	var init_check = Inventory.initialize_resource_data()
	LogManager.add_log("Resource_data - initialized: [%s]" % [init_check], "sys", "green" if init_check else "red")
	init_check = PlayerData.initialize_player_data()
	LogManager.add_log("Player_data - initialized: [%s]" % [init_check], "sys", "green" if init_check else "red")


func _on_auto_save_timer_timeout():
	save_game()
