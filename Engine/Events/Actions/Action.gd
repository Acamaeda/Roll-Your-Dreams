class_name Action
extends "res://Engine/Events/Triggers/EventBase.gd"
@export var wait_for_complete: bool = true


func act():
	active = true
	await action()
	active = false
	finished.emit()
	
func action():
	pass
