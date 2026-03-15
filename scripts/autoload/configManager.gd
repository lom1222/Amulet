extends Node

const CONFIG_FILE_PATH = "user//:config_0.cfg"

var configs = {
	"AUTO_SAVE_FREQUENCY": 60.0,
	"UNLOCK_CHECK_FREQUENCY": 1.0,
	"DISABLE_SAVING": false,
	"DISABLE_LOADING": false,
	"PRINT_CONFIGS_ON_STARTUP": true
}

func _ready() -> void:
	_load_configs()
	if configs["PRINT_CONFIGS_ON_STARTUP"]:
		print(configs)
	
func _on_save_timer_timeout():
	save_configs()

func save_configs():
	var config_file = ConfigFile.new()
	
	for config_name in configs:
		config_file.set_value("Configs", config_name, configs[config_name])
	
	config_file.save(CONFIG_FILE_PATH)
	LogManager.add_log("Configs Saved Successfully", "sys", "green")

func _load_configs():
	var config_file = ConfigFile.new()
	var err = config_file.load(CONFIG_FILE_PATH)
	
	if err == OK:
		for config_name in configs:
			configs[config_name] = config_file.get_value("Configs", config_name, configs[config_name])
	
