extends Node

var resources: Dictionary[String, GameResource] = {}

func _ready() -> void:
	resources = ResourceData.get_resources()
	
func _process(delta: float) -> void:
	for resource in resources.values():
		resource.update(delta)
	return

func initialize_resource_data():
	return true
