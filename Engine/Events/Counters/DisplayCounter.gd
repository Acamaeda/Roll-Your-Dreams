@tool
extends Counter
class_name DisplayCounter

@export var unit = ""
@export var pre_unit = ""
@export var decimal_places = 0
@export_enum("None", "Abbreviated", "Full")  var metric_prefixes = 0

var display_name = ""

func _ready():
	display_name = name
	super()
	
func format():
	var text = pre_unit
	match metric_prefixes:
		0:
			text += Utils.format.number(value, decimal_places)
		1:
			text += Utils.format.metric(value, false, decimal_places)
		2:
			text += Utils.format.metric(value, true, decimal_places)
	text += unit
	return text
	
	
func _validate_property(property: Dictionary):
	super(property)
