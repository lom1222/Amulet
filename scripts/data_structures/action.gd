@tool
extends Resource
class_name GameAction

@export var name = "blank"
@export var tooltip = "blank"
@export var icon: Texture2D
var unlocked = false
var depreciated = false

@export var resource_modifiers: Array[ModifierEntry] = []:
	set(value):
		resource_modifiers = value
		print(resource_modifiers[resource_modifiers.size()-1])
		if resource_modifiers[resource_modifiers.size()-1] == null:
			resource_modifiers[resource_modifiers.size()-1] = ModifierEntry.new()
