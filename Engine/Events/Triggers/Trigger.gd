class_name Trigger
extends "res://Engine/Events/Triggers/EventBase.gd"
@export var repeatable: bool = false

var waiting_for_done = false
var condition_failed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.finished.connect(check_done)


func trigger():
	if (active):
		return
	active = true
	condition_failed = false
	
	for child in get_children():
		if child is Action:
			condition_failed = false
			if(child.wait_for_complete):
				await child.act()
			else: 
				child.act()
		if child is ConditionTrigger:
			if (await child.check_condition()):
				condition_failed = false
				await child.trigger()
			else:
				condition_failed = true
	waiting_for_done = true
	check_done()

func check_done():
	if (waiting_for_done):
		for child in get_children():
			if child.active:
				return
		active = false
		if get_parent() is Trigger:
			finished.emit()
			return
		if !repeatable:
			queue_free()


	
