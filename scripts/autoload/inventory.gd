extends Node

var resources: Dictionary[String, GameResource] = {}

const RESOURCE_LIST: Array[String] = [
	"food"
]


func _ready() -> void:
	for resource_name in RESOURCE_LIST:
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
	resources["food"].rate_enabled = true
	resources["food"].resource_pool = 1000000000
	return true
	
func unlock_resource(resource_name):
	resources[resource_name].unlocked = true
	GlobalSignals.resource_unlocked.emit(resource_name)
	return
