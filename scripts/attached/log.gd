extends RichTextLabel


func _ready() -> void:
	text = ""
	LogManager.message_logged.connect(_on_message_logged)
	
	LogManager.add_log("You awake.")
	LogManager.add_log("The first thing you see are your hands, and in them, a shinning amulet.")
	LogManager.add_log("You put it on, and tear your focus away. You are hungry. You dont know where you are.")
	
func _on_message_logged(_message_text: String):
	clear()
	for entry in LogManager.message_history:
		append_text(entry + "\n")
