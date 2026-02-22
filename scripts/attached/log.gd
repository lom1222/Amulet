extends TabContainer

@export var lore_log: RichTextLabel
@export var event_log: RichTextLabel
@export var sys_log: RichTextLabel

func _ready() -> void:
	lore_log.text = ""
	event_log.text = ""
	sys_log.text = ""
	
	LogManager.log_updated.connect(_on_log_updated)
	
	LogManager.add_log("You awake.", "lore")
	LogManager.add_log("The first thing you see are your hands, and in them, a shinning amulet.", "lore")
	LogManager.add_log("You put it on, and tear your focus away. You are hungry. You dont know where you are.", "lore")
	
func _on_log_updated(_log_type : String):
	var cur_log: RichTextLabel
	if _log_type == "lore":
		cur_log = lore_log
	elif _log_type == "event":
		cur_log = event_log
	elif _log_type == "sys":
		cur_log = sys_log
	
	cur_log.clear()
	for entry in LogManager.log_history[_log_type]:
		cur_log.append_text(entry + "\n")
