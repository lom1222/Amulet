extends Node

const SAVE_FILE_PATH = "user://saves/save_0.cfg"

func _ready() -> void:
	var auto_save_timer =  Timer.new()
	add_child(auto_save_timer)
	
	auto_save_timer.wait_time = ConfigManager.configs["auto_save_frequency"]
	auto_save_timer.autostart = true
	
	auto_save_timer.timeout.connect(_on_auto_save_timer_timeout)
	
	auto_save_timer.start()
	return

func save_game():
	
	var save_file = ConfigFile.new()
	
	for resource_name in Inventory.resources:
		save_file.set_value("Resources", resource_name, Inventory.resources[resource_name])
	
	save_file.set_value("Meta", "save_time", Time.get_unix_time_from_system())
	
	save_file.save(SAVE_FILE_PATH)
	LogManager.add_log("Game Saved Successfully", "sys", "green")


func _on_auto_save_timer_timeout():
	save_game()
