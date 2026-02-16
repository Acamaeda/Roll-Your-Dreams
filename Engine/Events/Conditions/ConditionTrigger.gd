class_name ConditionTrigger
extends "res://Engine/Events/Triggers/Trigger.gd"
var is_conditional = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	if (get_parent() is Trigger):
		is_conditional = true
	pass # Replace with function body.

func check_condition():
	return true
	
