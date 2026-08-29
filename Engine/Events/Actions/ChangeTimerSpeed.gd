extends "res://Engine/Events/Actions/ChangeValue.gd"

@export var timer : RYDTimer

func get_current_value():
	return timer.rate

func apply_change(val):
	timer.rate = val
