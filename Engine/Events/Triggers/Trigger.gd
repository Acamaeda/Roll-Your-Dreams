extends "res://Engine/Events/Triggers/EventBase.gd"
@export var repeatable: bool = false
const Action = preload ("res://Engine/Events/Actions/Action.gd")

var waiting_for_done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.finished.connect(check_done)
	pass # Replace with function body.


func trigger():
	active = true
	for child in get_children():
		if child is Action:
			if(child.wait_for_complete):
				await child.act()
			else: 
				child.act()
	waiting_for_done = true
	check_done()

func check_done():
	if (waiting_for_done):
		for child in get_children():
			if child.active:
				return
		active = false
		if !repeatable:
			queue_free()
