extends "res://Engine/Events/Actions/Action.gd"
@export var print_message:String = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func action():
	print(print_message)
