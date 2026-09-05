@tool
extends Counter
class_name RYDTimer
@export var rate = 1.0

func _process(delta: float) -> void:
	if(!Engine.is_editor_hint()):
		value = value + rate*delta
 
func _validate_property(property: Dictionary):
	super(property)
