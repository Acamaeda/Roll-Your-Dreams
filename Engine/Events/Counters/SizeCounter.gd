@tool
extends Counter
class_name SizeCounter

var collector 

func _ready():
	if Engine.is_editor_hint():
		return
	collector = get_tree().get_first_node_in_group("Player").get_node("Collector")
	super()

func get_value():
	if (!collector): return 0.0
	return collector.size

func set_value(newval):
	if (!collector): return

	if (newval != collector.size):
		collector.set_size(newval)
		value_changed.emit(newval)


func _validate_property(property: Dictionary):
	if property.name == "value" || property.name == "min":
		property.usage = PROPERTY_USAGE_NO_EDITOR
	super(property)
	
func format():
	return Utils.format.formatSize(value)
