extends Resource
class_name GameAction

@export var name = "blank"
@export var tooltip = "blank"
@export var icon: Texture2D
var unlocked = false
var depreciated = false

@export var resource_modifiers: Array[ModifierEntry]
