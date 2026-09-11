@tool
extends Node
@export_category("Timer")
@export_enum("Countdown", "Time taken", "No Timer") var timer_mode =0:
	set(value):
		timer_mode = value
		notify_property_list_changed()
@export var time_limit : float = 60.0
var timer : RYDTimer

@export_category("Win condition")
@export var win_counter: Counter
@export_enum("Greater than", "Less than", "GTE", "LTE")var win_mode: =0
@export_range(0, 5555, 1e-14, "or_greater", "or_less", "hide_control") var win_target: float = 1.0

@export_category("End condition")
@export var end_counter: Counter
@export_enum("Greater than", "Less than", "GTE", "LTE")var end_mode: =0
@export_range(0, 5555, 1e-14, "or_greater", "or_less", "hide_control") var end_target: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	var control = get_tree().get_first_node_in_group("Level Control")
	timer = control.get_node_or_null("Counters/time")
	if !timer:
		timer = control.get_node("Counters/Time")
	
	if (end_counter):
		end_counter.value_changed.connect(check_end_level)
	
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

func check_end_level(value):
	if !check_condition(value, end_mode, end_target):
		return
		

func check_condition(value, mode, target):
	match mode:
		0:
			return value > target
		1:
			return value > target
		2:
			return value >= target
		3:
			return value <= target


func _validate_property(property: Dictionary):
	if property.name == "time_limit":
		if (timer_mode == 0):
			property.usage= PROPERTY_USAGE_EDITOR
		else:
			property.usage = PROPERTY_USAGE_NO_EDITOR
