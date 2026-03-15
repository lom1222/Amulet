extends Control


func _ready() -> void:
	ready.connect(_on_ready)
	
func _on_ready():
	GlobalSignals.emit_game_ready()
