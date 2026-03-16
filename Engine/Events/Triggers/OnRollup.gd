extends "res://Engine/Events/Triggers/Trigger.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("../Rollable").onRollup.connect(trigger)
