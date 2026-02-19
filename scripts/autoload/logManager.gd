extends Node

signal log_updated(log_type)

var log_history = {
	"lore" = [],
	"event"= [],
	"error" = []
}
#var message_history: Array[String] = []
#var event_history: Array[String] = []
#var error_history: Array[String] = []
const MAX_LOGS = 100

func add_log(text: String, log_type: String = "lore", color: String = "white"):
	var new_log_entry = "[color=%s]%s[/color]" % [color, text]
	
	log_history[log_type].append(new_log_entry)
	if log_history[log_type].size() > MAX_LOGS:
		log_history[log_type].remove_at(0)
	log_updated.emit(log_type)
	
	
	#if log_type == "log":
		#message_history.append(new_log_entry)
		#if message_history.size() > MAX_LOGS:
			#message_history.remove_at(0)
		#message_logged.emit(new_log_entry)
	#elif log_type == "event":
		#event_history.append(new_log_entry)
		#if event_history.size() > MAX_LOGS:
			#event_history.remove_at(0)
		#event_logged.emit(new_log_entry)
	#elif log_type == "error":
		#error_history.append(new_log_entry)
		#if error_history.size() > MAX_LOGS:
			#error_history.remove_at(0)
		#error_logged.emit(new_log_entry)
