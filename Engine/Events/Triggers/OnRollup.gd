extends "res://Engine/Events/Triggers/Trigger.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rollable = get_node("../Rollable")
	if rollable:
		rollable.onRollup.connect(trigger)
	else:
		push_warning("OnRollup trigger is not on a rollable!")
