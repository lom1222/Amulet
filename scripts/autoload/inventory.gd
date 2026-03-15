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
	
func unlock_resource(resource_name):
	resources[resource_name].unlocked = true
	GlobalSignals.emit_resource_unlocked(resource_name)
	return
