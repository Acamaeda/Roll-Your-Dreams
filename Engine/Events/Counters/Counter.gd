@tool
extends Node
class_name Counter
@export var value = 0.0:
	set(newval):
		if (newval != value):
			value = newval
			value_changed.emit(value)
signal value_changed(value)

func _validate_property(property: Dictionary):
	pass
