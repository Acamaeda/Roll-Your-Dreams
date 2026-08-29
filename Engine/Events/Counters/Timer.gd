extends Counter
class_name RYDTimer
@export var rate = 1.0

func _process(delta: float) -> void:
	value = value + rate*delta
 
