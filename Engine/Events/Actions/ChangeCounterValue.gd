extends "res://Engine/Events/Actions/ChangeValue.gd"

@export var counter_to_change : Counter

func get_current_value():
	return counter_to_change.value

func apply_change(val):
	counter_to_change.value = val
