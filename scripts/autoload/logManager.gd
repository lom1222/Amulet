extends Node

signal log_updated(log_type)

const time_stamp_color = "teal"

var log_history = {
	"lore" = [],
	"event"= [],
	"sys" = []
}
const MAX_LOGS = 100

func add_log(text: String, log_type: String = "lore", color: String = "white"):
	var new_log_entry = "[color=%s]%s[/color]" % [color, text]
	
	var time_stamp = ""
	if log_type == "sys":
		time_stamp = Time.get_datetime_string_from_system(false, true)
	else:
		time_stamp = Time.get_time_string_from_unix_time(PlayerData.game_time)
	new_log_entry = "[color=%s][%s][/color] %s" % [time_stamp_color, time_stamp, new_log_entry]
	
	log_history[log_type].append(new_log_entry)
	if log_history[log_type].size() > MAX_LOGS:
		log_history[log_type].remove_at(0)
	log_updated.emit(log_type)
	
