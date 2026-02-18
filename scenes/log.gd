extends RichTextLabel


func _ready() -> void:
	text = ""
	LogManager.message_logged.connect(_on_message_logged)
	
func _on_message_logged(_message_text: String):
	clear()
	for entry in LogManager.message_history:
		append_text(entry + "\n")
