@tool
extends Node
class_name Counter
@export var value = 0.0:
	set(newval):
		if (newval != value):
			value = newval
			value_changed.emit(value)
signal value_changed(value)

func _ready():
	if (!Engine.is_editor_hint()):
		name = name.to_lower()
	
func _validate_property(_property: Dictionary):
	pass
