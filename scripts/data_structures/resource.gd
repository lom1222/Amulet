class_name GameResource

var name = "blank"
var amount = 0.0
var rate = 0.0

var unlocked = false

var base = 0.0
var increased_multiplier = 1.0
var more_multipliers = [1.0]

func update(delta):
	amount += rate*delta
	
func checkRate():
	rate = base * increased_multiplier
	for mult in more_multipliers:
		rate *= mult
