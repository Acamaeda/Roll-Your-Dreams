extends "res://Engine/Events/Actions/Action.gd"
class_name ChangeValue

@export var amount:float = 1.0
@export_enum("Set", "Add", "Multiply", "Subtract", "Divide") var mode = 0

func action():
	var current = get_current_value()
	match mode:
		0:
			apply_change.call_deferred(amount)
		1: 
			apply_change.call_deferred(current+amount)
		2: 
			apply_change.call_deferred(current*amount)
		3: 
			apply_change.call_deferred(current-amount)
		4: 
			print (current/amount)
			if (amount != 0.0):
				apply_change.call_deferred(current/amount)		
						
func get_current_value():
	return 0.0
	
func apply_change(_val):
	pass
