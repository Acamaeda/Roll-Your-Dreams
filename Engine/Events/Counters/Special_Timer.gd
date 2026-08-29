@tool
extends RYDTimer


func _validate_property(property: Dictionary):
	if property.name == "rate" || property.name == "value":
		property.usage = PROPERTY_USAGE_NO_EDITOR

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!Engine.is_editor_hint()):
		super(delta)
