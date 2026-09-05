@tool
extends DisplayCounter
class_name ScoreCounter

@export var object_values : Dictionary[String, float]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func add_from_object(object:String):
	var add = object_values.get(object, 0)
	if (add):
		value += add
	print(value)
