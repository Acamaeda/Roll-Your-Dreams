class_name Otherwise
extends "res://Engine/Events/Conditions/ConditionTrigger.gd"

func check_condition():
	var parent = get_parent()
	if !parent is Trigger:
		push_warning("Otherwise trigger is not inside of a Trigger.")
		return false
	else:
		return !parent.condition_failed
