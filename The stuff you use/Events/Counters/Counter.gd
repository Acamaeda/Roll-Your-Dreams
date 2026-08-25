extends Node
@export var value = 0.0:
	set(newval):
		if (newval != value):
			value = newval

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
