@tool
extends Node
class_name Counter
@export var value = 0.0:
	set = set_value,
	get = get_value
signal value_changed(value)

func _ready():
	if (!Engine.is_editor_hint()):
		name = name.to_lower()
	
func _validate_property(_property: Dictionary):
	pass

func set_value(newval):
	if (newval != value):
		value = newval
		value_changed.emit(newval)
		
func get_value():
	return value
