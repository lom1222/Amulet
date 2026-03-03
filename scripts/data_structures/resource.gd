extends RefCounted
class_name GameResource

var name: String = "blank"
var tooltip: String = "blank"
var amount: float = 0.0
var rate: float = 0.0

var unlocked: bool = false
var rate_enabled: bool = false
var depreciated: bool = false

var is_limited_resource: bool = true
var resource_pool: float = 0

var base_rate: float = 0
var percent_increase: float = 100
var final_multiplier: float = 1
var base_rate_modifiers: Dictionary[String, float] = {}
var percent_increase_modifiers: Dictionary[String, float] = {}
var multipliers: Dictionary[String, float] = {}

var total_created: float = 0

func update(delta):
	if depreciated or not rate_enabled:
		return
	var resource_delta = rate*delta
	if is_limited_resource and resource_pool < resource_delta:
		resource_delta = resource_pool
	amount += resource_delta
	total_created += resource_delta
		
func update_rate_and_ui():
	if depreciated:
		return
	_update_rate_variables()
	rate = _get_new_rate()
	tooltip = _generate_tooltip()
	GlobalSignals.resource_tooltip_changed.emit(self)
	

func _get_new_rate() -> float:
	if not rate_enabled:
		return 0.0
	base_rate = _get_base_rate()
	percent_increase = _get_percent_multiplier()
	final_multiplier = _get_total_multiplier()
	var new_rate = base_rate * (100 + percent_increase) / 100 * final_multiplier
	return new_rate
	
func _get_base_rate() -> float:
	var new_base_rate: float = 0
	for modifier in base_rate_modifiers.values():
		new_base_rate += modifier
	return new_base_rate
	
func _get_percent_multiplier() -> float:
	var new_percent_multiplier: float = 0
	for modifier in percent_increase_modifiers.values():
		new_percent_multiplier += modifier
	return new_percent_multiplier

func _get_total_multiplier() -> float:
	var new_total_multiplier: float = 1
	for modifier in multipliers.values():
		new_total_multiplier *= modifier
	return new_total_multiplier

func _generate_tooltip() -> String:
	var tooltip_lines: Array[String] = []
	
	tooltip_lines.append("[color=%s][b]%s:[/b][/color]" % ["white",name.capitalize()])
	
	if not base_rate_modifiers.is_empty():
		tooltip_lines.append("[color=%s][b]   Production:[/b][/color]" % ["grey"])
		tooltip_lines.append_array(_get_sorted_tooltip_lines(base_rate_modifiers, ""))
		tooltip_lines.append("[color=%s][b]   Total production: %s[/b][/color]" % ["grey", str(base_rate)])
	
	if not percent_increase_modifiers.is_empty():
		tooltip_lines.append("[color=%s][b]   Production Increase:[/b][/color]" % ["grey"])
		tooltip_lines.append_array(_get_sorted_tooltip_lines(percent_increase_modifiers, "%"))
		tooltip_lines.append("[color=%s][b]   Total Prod Increase: %s[/b][/color]" % ["grey", str(percent_increase)+"%"])
	
	if not multipliers.is_empty():
		tooltip_lines.append("[color=%s][b]   Total Multipliers:[/b][/color]" % ["grey"])
		tooltip_lines.append_array(_get_sorted_tooltip_lines(multipliers, "x"))
		tooltip_lines.append("[color=%s][b]   Total Multiplier: %sx[/b][/color]" % ["grey", str(final_multiplier)])
	
	tooltip_lines.append("[color=%s][b]Final Rate: %s[/b][/color]\n" % ["white", str(rate)])
	
	return "\n".join(tooltip_lines)
	
func _get_sorted_tooltip_lines(modifier_dictionary: Dictionary, suffix: String) -> Array[String]:
	var modifier_sources = modifier_dictionary.keys()
	modifier_sources.sort()
	var tooltip_lines : Array[String] = []
	for source: String in modifier_sources:
		var modifier_value = modifier_dictionary[source]
		tooltip_lines.append("[color=%s]      %s[/color]: [color=%s]%s%s[/color]" % ["grey",source, "green" if modifier_value > 0 else "red", modifier_value, suffix])
	return tooltip_lines

func _update_rate_variables():
	var all_modifiers: Array[ModifierEntry] = []
	
	all_modifiers.append_array(_get_action_modifiers(self.name))
	all_modifiers.append_array(_get_building_modifiers(self.name))
	all_modifiers.append_array(_get_upgrade_modifiers(self.name))
	all_modifiers.append_array(_get_research_modifiers(self.name))
	
	var new_base_rate_modifiers: Dictionary[String, float] = {}
	var new_increased_multiplier_modifiers: Dictionary[String, float] = {}
	var new_multipliers: Dictionary[String, float] = {}
	
	for modifier: ModifierEntry in all_modifiers:
		if modifier.resource != self.name:
			LogManager.add_log("Invalid Modifier", "sys", "red")
			continue
		if modifier.base_increased != 0:
			new_base_rate_modifiers[modifier.source] = modifier.base_increased
		if modifier.percent_increased != 0:
			new_increased_multiplier_modifiers[modifier.source] = modifier.percent_increased
		if modifier.multiplier != 1:
			new_multipliers[modifier.source] = modifier.multiplier
	
	base_rate_modifiers = new_base_rate_modifiers
	percent_increase_modifiers = new_increased_multiplier_modifiers
	multipliers = new_multipliers
	
func _get_upgrade_modifiers(_resource: String) -> Array[ModifierEntry]:
	return []
	
func _get_building_modifiers(_resource: String) -> Array[ModifierEntry]:
	return []
	
func _get_action_modifiers(resource: String) -> Array[ModifierEntry]:
	var action_modifiers: Array[ModifierEntry] = []
	for action: GameAction in ActionManager.active_actions:
		for modifier: ModifierEntry in action.resource_modifiers:
			if modifier.resource == self.name:
				modifier.source = action.name
				modifier.source_type = "action"
				action_modifiers.append(modifier)
	return action_modifiers
	
func _get_research_modifiers(_resource: String) -> Array[ModifierEntry]:
	return []
	
func get_save_data() -> Dictionary:
	return {
		"amount": amount,
		"unlocked": unlocked,
		"rate_enabled": rate_enabled,
		"depreciated": depreciated,
		"is_limited_resource": is_limited_resource,
		"resource_pool": resource_pool,
		"total_created": total_created
	}
	
func load_from_data(data):
	amount = data["amount"]
	unlocked = data["unlocked"]
	rate_enabled = data["rate_enabled"]
	depreciated = data["depreciated"]
	is_limited_resource = data["is_limited_resource"]
	resource_pool = data["resource_pool"]
	total_created = data["total_created"]
	update_rate_and_ui()
