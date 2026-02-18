extends Node

signal message_logged(message_text)
signal event_logged(event_text)
signal error_logged(error_text)

var message_history: Array[String] = []
var event_history: Array[String] = []
var error_history: Array[String] = []
const MAX_LOGS = 100

func add_log(text: String, color: String = "white", type: String = "log"):
	var new_log_entry = "[color=%s]%s[/color]" % [color, text]
	
	if type == "log":
		message_history.append(new_log_entry)
		if message_history.size() > MAX_LOGS:
			message_history.remove_at(0)
		message_logged.emit(new_log_entry)
	elif type == "event":
		event_history.append(new_log_entry)
		if event_history.size() > MAX_LOGS:
			event_history.remove_at(0)
		event_logged.emit(new_log_entry)
	elif type == "error":
		error_history.append(new_log_entry)
		if error_history.size() > MAX_LOGS:
			error_history.remove_at(0)
		error_logged.emit(new_log_entry)
