extends ItemList

var update_frequency = 0.1
var time_since_update = 0.0

var resource_indexes = {}

func _ready() -> void:
	Inventory.resource_unlocked.connect(_on_resource_unlocked)
	_build_ui_list()
	
func _build_ui_list():
	clear()
	resource_indexes.clear()
	for resource in Inventory.resources.values():
		if resource.unlocked:
			var list_index = add_item(resource.name, null, false)
			set_item_tooltip(list_index, resource.tooltip)
			resource_indexes[resource.name] = list_index
	_update_ui_values()
	
	
func _process(delta: float) -> void:
	time_since_update += delta
	if time_since_update >= update_frequency:
		time_since_update -= update_frequency
		_update_ui_values()
	
func _update_ui_values():
	for resource_name in resource_indexes:
		var index = resource_indexes[resource_name]
		var value = Inventory.resources[resource_name].amount
		var new_text = "%s: %d" % [resource_name.capitalize(), floor(value)]
		
		set_item_text(index, new_text)

func _update_tooltip_values():
	return

func _on_resource_unlocked(_resource_name):
	_build_ui_list()
