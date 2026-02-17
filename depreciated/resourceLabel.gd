extends Label


@export var resource_name = "Food"

func _ready() -> void:
	var data = Inventory.resources[resource_name]
	return

func _update_text(value):
	text = resource_name + ": " + str(floor(value))
