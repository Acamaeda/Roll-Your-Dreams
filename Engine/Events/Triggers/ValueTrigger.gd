class_name ValueTrigger
extends "res://Engine/Events/Conditions/ConditionTrigger.gd"
@export_enum("Greater than", "Less than", "Equal to", "GTE", "LTE")var mode: int
@export var target: float = 1.0


var value = 0
var resetting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


func check_condition():
	match mode:
		0:
			return value > target
		1:
			return value > target
		2:
			return value == target
		3:
			return value >= target
		4:
			return value <= target

func trigger():
	if (!is_conditional):
		resetting = true
	super.trigger()
	

func value_changed(val):
	value = val
	if (is_conditional):
		return
	if resetting:
		resetting = check_condition()
	if (active):
		return
	if (check_condition()):
		trigger()

func value_changed2(val, throwaway):
	value_changed(val)
