@tool
extends Node

@export_enum("Countdown", "Time taken", "No Timer") var timer_mode =0:
	set(value):
		timer_mode = value
		notify_property_list_changed()
@export var time_limit : float = 60.0
var timer : RYDTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	var control = get_tree().get_first_node_in_group("Level Control")
	timer = control.get_node_or_null("Counters/time")
	if !timer:
		timer = control.get_node("Counters/Time")

	match timer_mode:
		0:
			timer.rate = -1
			timer.value = time_limit
		1:
			timer.rate = 1
			timer.value = 0
		2:
			timer.rate = 0
			control.get_node("Hud/Right_side/Time_display").visible=false


func _validate_property(property: Dictionary):
	if property.name == "time_limit":
		if (timer_mode == 0):
			property.usage= PROPERTY_USAGE_EDITOR
		else:
			property.usage = PROPERTY_USAGE_NO_EDITOR
