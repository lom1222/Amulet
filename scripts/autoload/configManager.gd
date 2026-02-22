extends Node

const CONFIG_FILE_PATH = "user//:config_0.cfg"

var configs = {
	"auto_save_frequency": 60.0,
	
}

func _ready() -> void:
	load_configs()

func save_configs():
	var config_file = ConfigFile.new()
	
	for config_name in configs:
		config_file.set_value("Configs", config_name, configs[config_name])
	
	config_file.save(CONFIG_FILE_PATH)
	LogManager.add_log("Configs Saved Successfully", "sys", "green")

func load_configs():
	var config_file = ConfigFile.new()
	var err = config_file.load(CONFIG_FILE_PATH)
	
	if err == OK:
		for config_name in configs:
			configs[config_name] = config_file.get_value("Configs", config_name, configs[config_name])
			
	
