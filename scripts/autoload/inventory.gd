extends Node


var resources = {}

var resource_list = [
	"food"
]

func _ready() -> void:
	for resource_name in resource_list:
		var new_resource = GameResource.new()
		new_resource.name = resource_name
		resources[resource_name] = new_resource
	return
	
func _process(delta: float) -> void:
	for resource in resources.values():
		resource.update(delta)
	return
