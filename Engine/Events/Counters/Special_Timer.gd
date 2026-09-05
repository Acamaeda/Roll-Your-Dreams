@tool
extends RYDTimer


func _validate_property(property: Dictionary):
	if property.name == "rate" || property.name == "value":
		property.usage = PROPERTY_USAGE_NO_EDITOR
	super(property)
