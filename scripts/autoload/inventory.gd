extends Node

var resources: Dictionary[String, GameResource] = {}

var resource_list: Array[String] = [
	"food"
]

signal resource_unlocked(resource_name)

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

func initialize_resource_data():
	unlock_resource("food")
	resources["food"].amount = 100
	return true
	
func unlock_resource(resource_name):
	resources[resource_name].unlocked = true
	resource_unlocked.emit(resource_name)
	return
