@tool
extends ScoreCounter

@export var countdown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	get_tree().get_first_node_in_group("Player").get_node("Collector").rolled_up.connect(add_object)
	super()

func add_object(_obj):
	if(countdown):
		value -= 1
	else:
		value += 1

func _validate_property(property: Dictionary):
	if property.name == "object_values" || property.name == "unit" || property.name == "pre_unit" || property.name == "decimal_places" || property.name == "metric_prefixes":
		property.usage = PROPERTY_USAGE_NO_EDITOR
	super(property)
