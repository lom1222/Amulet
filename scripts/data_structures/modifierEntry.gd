class_name ModifierEntry extends Resource

var resource : String
var base_increased : float
var percent_increased : float
var multiplier : float

var source : String = ""
var source_type : String = ""

func _init(_resource : String = "blank", _base_increased : float = 0.0, _percent_increased : float = 0.0, _multiplier : float = 1.0) -> void:
	resource = _resource
	base_increased = _base_increased
	percent_increased = _percent_increased
	multiplier = _multiplier
