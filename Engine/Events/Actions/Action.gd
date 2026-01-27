extends "res://Engine/Events/Triggers/EventBase.gd"
signal finished()
@export var wait_for_complete: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func act():
	active = true
	await action()
	active = false
	finished.emit()
	
func action():
	pass
